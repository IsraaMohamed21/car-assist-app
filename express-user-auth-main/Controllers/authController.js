

import bcryptjs from "bcryptjs";
import query from "../db-connection/connection.js";
import jwt from "jsonwebtoken";

export const SignOut = async (req, res, next) => {
    res.clearCookie('jwt'); // Clear JWT cookie
    res.status(200).send('User signed out successfully.');
 
};



export const SignUp = async (req, res, next) => {

    const { name, password, email,phone } = req.body;


  try {
    

    const findUser = await query("select * from users where email = ? ", email)
    console.log(findUser);
    if (findUser.length > 0) {
        return res.status(400).send("Email already exists.");
    }

    const HashedPassword = bcryptjs.hashSync(password,10);
  

    const user = await query("insert into users (email, password, phone_number, username) values (?,?,?,?)", [email, HashedPassword, phone, name])
    const insertedUser = await query("SELECT * FROM users WHERE id = ?", user.insertId);
    res.status(201).send({message:"User registered successfully" ,user: insertedUser[0]});
  } catch (error) {
    console.error("Error registering user:", error);
    res.status(500).send("An error occurred while registering the user.");
  }
};

export const Login = async (req, res) => {

    const { email, password} = req.body;

  try {
    const findUser = await query("select * from users where email = ? ", email)
    if (findUser.length == 0) {
        return res.status(400).send("Email does not exist");
    }
    const passwordMatch = await bcryptjs.compare(password, findUser[0].password);
    if (!passwordMatch)  return res.status(401).send("Wrong Password");

 


    const userData = {
        username: findUser[0].username,
        email: findUser[0].email,
        phone_number: findUser[0].phone_number,
    
    };


      const token = jwt.sign({ id: findUser[0].id, email: findUser[0].email }, 'your_secret_key', { expiresIn: '2h' });

      res.cookie('jwt', token, { httpOnly: true }); // Set JWT token as cookie
    res.status(201).send({message:"User Loggedin successfully." ,user: userData});

  } catch (error) {
    console.error("Error login user:", error);
    res.status(500).send("An error occurred while Loggingin the user.");
  }
  
};

export const verfyToken = (req, res, next) => {
    const token = req.cookies.jwt || req.headers.authorization?.split(' ')[1];
console.log(token)
    if (!token) {
        return res.status(401).send('Unauthorized: No token provided');
    }

    try {
        // Verify JWT token
        const decodedToken = jwt.verify(token, 'your_secret_key');
        console.log(decodedToken);  
        req.user = decodedToken; // Attach decoded token data to request object
        next(); // Call next middleware
    } catch (error) {
        console.error('Error verifying token:', error);
        return res.status(401).send('Unauthorized: Invalid token');
    }
 };

 export const getUserData = (req, res) => {
    try {
        // Get user data from the decoded JWT token attached to the request
        const userData = req.user;
        res.status(200).json(userData);
    } catch (error) {
        console.error("Error getting user data:", error);
        res.status(500).send("An error occurred while fetching user data.");
    }
};