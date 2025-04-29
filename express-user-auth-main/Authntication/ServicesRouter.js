import  express  from "express";
import { ReqWinch ,GetDestinations,GetMechanicsLocations,GetMecName,SendRate} from "../Controllers/ServicesController.js";
import {verfyToken} from "../Controllers/authController.js"
  

const router = express.Router();
  
  

 
router.post('/ReqWinch',verfyToken,ReqWinch)
router.get('/Destinations',verfyToken,GetDestinations)
router.post('/GetMecLocations',verfyToken,GetMechanicsLocations)
router.get('/GetMec/:name',verfyToken,GetMecName)
router.post('/Rating',verfyToken,SendRate)
  

export default router;