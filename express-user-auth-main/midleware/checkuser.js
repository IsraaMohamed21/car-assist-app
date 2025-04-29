import express from 'express';
import jwt from 'jsonwebtoken';


const key = "secretkey";


const checkUser = async (req, res, next) => {
    try {
        let error = [];
        let token = req.headers.authorization
        if (!token) {
            error.push({ user: false, msg: "Unauthorized" });
            return res.status(401).json(error);
        } else {
            token = token.split(" ")[1];
            jwt.verify(token, key, (err, decoded) => {
                if (err) {
                    console.log(err);
                    error.push({ user: true, msg: err });
                    return res.status(401).json(error);
                }
                req.userId = decoded.userId;
                req.username = decoded.username;
                req.email = decoded.email;
                req.phone_number = decoded.phone_number;
                next();
            }
            );
        }



    } catch (err) {
        return res.status(500).json("user Error");
    }
}

export default checkUser;