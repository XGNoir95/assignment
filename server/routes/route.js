import express from 'express';
import { signupUser, loginUser, logoutUser } from '../controller/user-controller.js';
import { createPost, updatePost, deletePost, getPost, getAllPosts } from '../controller/post-controller.js';
import { uploadImage, getImage } from '../controller/image-controller.js';
//import { newComment, getComments, deleteComment } from '../controller/comment-controller.js';
import { authenticateToken, createNewToken } from '../controller/jwt-controller.js';
import upload from '../utils/upload.js';

const router = express.Router();

// User routes
router.post('/signup', signupUser);
// Route for user login
router.post('/login', async (req, res) => {
    try {
        const { username, password } = req.body;

        // Example of simple validation (replace with your actual validation logic)
        if (!username || !password) {
            return res.status(400).json({ message: 'Username and password are required' });
        }

        // Call controller function to handle login logic
        const loginResult = await loginUser(username, password);

        // Example of handling successful login
        if (loginResult.success) {
            return res.status(200).json({ message: 'Login successful', user: loginResult.user });
        } else {
            return res.status(401).json({ message: 'Invalid username or password' });
        }
    } catch (error) {
        console.error('Error in login:', error);
        return res.status(500).json({ message: 'Error while logging in the user' });
    }
});
router.post('/logout', logoutUser);

// Post routes
router.post('/create', authenticateToken, createPost);
router.put('/update/:id', authenticateToken, updatePost);
router.delete('/delete/:id', authenticateToken, deletePost);
router.get('/post/:id', authenticateToken, getPost);
router.get('/posts', authenticateToken, getAllPosts);

// Image routes
router.post('/file/upload', upload.single('file'), uploadImage);
router.get('/file/:filename', getImage);

// Comment routes


// Token route (if needed)
router.post('/token', createNewToken);

export default router;
