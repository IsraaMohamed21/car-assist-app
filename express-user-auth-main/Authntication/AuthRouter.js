import  express  from "express";
import { SignUp , Login, SignOut,getUserData,verfyToken} from "../Controllers/authController.js";



  

const router = express.Router();
  
  

 
router.post('/SignUp',SignUp)

router.get('/SignOut',SignOut)

router.post('/Login',Login)


router.get('/VerifyToken', verfyToken, getUserData);
  

export default router;