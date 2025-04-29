import express from "express";
import bcrypt from "bcrypt";
import query from "./db-connection/connection.js";
import auth from "./Authntication/userAuthentication.js";
import authRouter from "./Authntication/AuthRouter.js";
import service from "./router/service.js";
import emp from "./router/employee.js";
import cors from "cors";
import cookieParser from "cookie-parser"
import session from "express-session"
import ServRouter from "./Authntication/ServicesRouter.js"
const app = express();
const port = 5000;




app.use(express.json());
app.use(cookieParser());


const corsOptions = {
  origin: 'http://localhost:3000', // Allow requests from this origin
  credentials: true, // Allow credentials (cookies, authorization headers, etc.)
};

app.use(cors(corsOptions));

app.use(express.static("public/uploads"));

app.use(session({
  secret: 'your_secret_key',
  resave: false,
  saveUninitialized: false
}));

app.use("/api",authRouter)
app.use("/api",ServRouter)
app.use("/api/service",service)
app.use("/api/employee",emp)

app.listen(port, () => {
  console.log("Server is started on port 5000");
});

/**
 * add employee (mecanic, winch) (location, service_id, password, email, username) endpoint http://localhost:5000/api/employee/add (المفروض تبقي عند الادمن)
 * get all employees endpoint http://localhost:5000/api/employee/getAll (المفروض تبقي عند الادمن)
 * get all employees by service_id endpoint http://localhost:5000/api/employee/getAll/:service_id (drob down list)
 * add service (service_name, discription, image) endpoint http://localhost:5000/api/service/add المفروض تبقي عند الادمن احنا ضيفنا الاتنين عموما مش هنحتاجها تاني ممكن تحتاجها لما تيجي تعدل الصورة اللي بتعبر عن الخدمه  id for michanic = 1 ثوابت , id for winch = 2 const ثوابت
 * get all services endpoint http://localhost:5000/api/service/getAll (home page)
 * register user (email, password, phone, name) endpoint http://localhost:5000/api/register
 * login user (email, password) endpoint http://localhost:5000/api/login
 * add request (service_id, location, phone, employee_id) endpoint http://localhost:5000/api/service/addRequest require token (request_services page)
 * 
 */