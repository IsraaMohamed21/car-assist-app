import express from "express";
import { body, validationResult } from "express-validator";
import query from "../db-connection/connection.js";
import upload from "../midleware/upload.js";
import checkUser from "../midleware/checkuser.js";

const service = express();

service.use(express.Router());

service.get("/getAll",
    async (req, res) => {
        try {
            const data = await query("select * from services");
            res.status(200).json(data);
        } catch (err) {
            console.log(err);
            res.status(500).send({ message: err.message });
        }
    }
);

service.post("/add",
    upload.single("image"),
    body("service_name").notEmpty().withMessage("Service name is required"),
    body("discription").notEmpty().withMessage("Service description is required"),
    
    async (req, res) => {
        try {
            let error = [];
            const errors = validationResult(req);
            if (!errors.isEmpty()) {
                error = errors.array();
                return res.status(400).json({ errors: errors.array().map((err) => err.msg) });
            }
            const { service_name, discription } = req.body;
            const image = req.file.filename;
            const service = await query("insert into services (service_name, discription, image) values (?,?,?)", [service_name, discription, image]);
            if (service) {
                res.status(200).json({ message: "Service added !" });
            } else {
                res.status(400).json({ error: "Service not added !" });
            }
        } catch (err) {
            console.log(err);
            res.status(500).send({ message: err.message });
        }
    }
);

service.post("/addRequest",
    checkUser,
    body("service_id").notEmpty().withMessage("Service id is required"),
    body("location").notEmpty().withMessage("Location is required"),
    body("phone").notEmpty().withMessage("Phone number is required"),
    body("employee_id").notEmpty().withMessage("Employee id is required"),

    async (req, res) => {
        try {
            let error = [];
            const errors = validationResult(req);
            if (!errors.isEmpty()) {
                error = errors.array();
                return res.status(400).json({ errors: errors.array().map((err) => err.msg) });
            }
            // check if the service exists
            const service = await query("select * from services where id = ?", [req.body.service_id]);
            if (service.length === 0) {
                return res.status(400).json({ error: "Service does not exist !" });
            }
            // check if the employee exists
            const employee = await query("select * from employee where id = ?", [req.body.employee_id]);
            if (employee.length === 0) {
                return res.status(400).json({ error: "Employee does not exist !" });
            }
            // check if the employee is having the same service
            if (employee[0].service_id !== req.body.service_id) {
                return res.status(400).json({ error: "Employee does not have the same service !" });
            }
            let { service_id, location, phone, employee_id , distenation} = req.body;
            if (!distenation) {
                distenation = null;
            }
            const request = await query("insert into submit (services_id, location, phone_number, employee_id , distenation , user_id) values (?,?,?,?,?,?)", [service_id, location, phone, employee_id, distenation, req.userId]);
            if (request) {
                res.status(200).json({ message: "Service request added !" });
            } else {
                res.status(400).json({ error: "Service request not added !" });
            }
        } catch (err) {
            console.log(err);
            res.status(500).send({ message: err.message });
        }
    }
);

    


export default service;