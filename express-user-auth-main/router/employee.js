import express from "express";
import { body, validationResult } from "express-validator";
import query from "../db-connection/connection.js";
import upload from "../midleware/upload.js";
import bcrypt from "bcrypt";

const emp = express();

emp.use(express.Router());

emp.post("/add",
    body("location").notEmpty().withMessage("Location is required"),
    body("service_id").notEmpty().withMessage("Service id is required"),
    body("password").notEmpty().withMessage("Password is required"),
    body("email").notEmpty().withMessage("Email is required"),
    body("username").notEmpty().withMessage("Username is required"),

    async (req, res) => {
        try {
            let error = [];
            const errors = validationResult(req);
            if (!errors.isEmpty()) {
                error = errors.array();
                return res.status(400).json({ errors: errors.array().map((err) => err.msg) });
            }
            const { location, service_id, password, email, username } = req.body;
            // check if the employee already exists
            const check = await query("select * from employee where email = ?", [email]);
            if (check.length > 0) {
                return res.status(400).json({ error: "Employee already exists !" });
            }

            // check if the service exists
            const service = await query("select * from services where id = ?", [service_id]);
            if (service.length === 0) {
                return res.status(400).json({ error: "Service does not exist !" });
            }

            const hashedPassword = await bcrypt.hash(password, 10);

            const employee = await query("insert into employee (location, service_id, password, email, username) values (?,?,?,?,?)", [location, service_id, hashedPassword, email, username]);
            if (employee) {
                res.status(200).json({ message: "Employee added !" });
            } else {
                res.status(400).json({ error: "Employee not added !" });
            }
        } catch (err) {
            console.log(err);
            res.status(500).send({ message: err.message });
        }
    }
);

emp.get("/getAll",
    async (req, res) => {
        try {
            const data = await query("select * from employee");
            res.status(200).json(data);
        } catch (err) {
            console.log(err);
            res.status(500).send({ message: err.message });
        }
    }
);

emp.get("/get/:service_id",
    async (req, res) => {
        try {
            const { service_id } = req.params;
            if (!service_id) {
                return res.status(400).json({ error: "Employee id is required !" });
            }
            const data = await query("select * from employee where service_id = ?", [service_id]);
            if (data.length === 0) {
                return res.status(400).json({ error: "Employee not found !" });
            }
            res.status(200).json(data);
        } catch (err) {
            console.log(err);
            res.status(500).send({ message: err.message });
        }
    }
);

export default emp;