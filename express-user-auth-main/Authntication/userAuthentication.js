import express from "express";
import query from "../db-connection/connection.js";
import { body, validationResult } from "express-validator";
import jwt from "jsonwebtoken"
import bcrypt from "bcrypt";
const key = "secretkey";
const auth = express()
auth.use(express.Router())


auth.post("/register",
  body("email").notEmpty().withMessage("Email is required"),
  body("password").notEmpty().withMessage("Password is required").isLength({ min: 8 }).withMessage("Password not less than 8 digits"),
  body("phone").notEmpty().withMessage("Phone is required"),
  body("name").notEmpty().withMessage("Name is required"),
  async (req, res) => {
    try {
      let error = [];
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        error = errors.array();
        return res.status(400).json({ errors: errors.array().map((err) => err.msg) })
      }
      const { email, password, phone, name } = req.body;
      // Find user
      const findUser = await query("select * from users where email = ? ", email)
      if (findUser.length > 0) {
        error.push("Email already exists !")
        return res.status(400).json({ errors: error });
      }
      // Hash password
      const hashedPassword = await bcrypt.hash(password, 10);
      // Create user
      const user = await query("insert into users (email, password, phone_number, username) values (?,?,?,?)", [email, hashedPassword, phone, name])
      if (user) {
        const findUser = await query("select * from users where email = ? ", email)
        if (findUser.length == 0) {
          res.status(400).send("User not created !")
        }
        // Create token
        console.log(findUser[0].id)
        const payload = {
          userId: findUser[0].id,
          username: findUser[0].username,
          email: findUser[0].email,
          phone_number: findUser[0].phone_number
        }
        const token = jwt.sign(payload, key, { expiresIn: "1d" }); // 1 day
        res.status(200).json({ login: true, token: token });
      }
      else {
        res.status(400).send("User not created !");
      }


    } catch (err) {
      console.log(err)
      res.status(500).send({ message: err.message });
    }
  });

auth.post("/login",
  body("email").notEmpty().withMessage("Email is required"),
  body("password").notEmpty().withMessage("Password is required"),
  async (req, res) => {
    try {
      let error = [];
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        error = errors.array();
        return res.status(400).json({ errors: errors.array().map((err) => err.msg) })
      }
      const { email, password } = req.body;
      // Find user
      const findUser = await query("select * from users where email = ? ", email)
      if (findUser.length == 0) {
        error.push("Email not found !")
        return res.status(400).json({ errors: error });
      }

      const passwordMatch = await bcrypt.compare(password, findUser[0].password);
      if (passwordMatch) {
        // Create token
        const payload = {
          userId: findUser[0].id,
          username: findUser[0].username,
          email: findUser[0].email,
          phone_number: findUser[0].phone_number
        }
        const token = jwt.sign(payload, key, { expiresIn: "1d" }); // 1 day
        return res.status(200).json({ login: true, token: "Bearer "+ token });
      } else {
        return res.status(400).send("Wrong email or password !");
      }
    } catch (err) {
      res.status(500).send({ message: err.message });
    }
  });
export default auth