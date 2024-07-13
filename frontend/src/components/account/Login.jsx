import React, { useState, useEffect, useContext } from 'react';
import { TextField, Box, Button, Typography, styled } from '@mui/material';
import { useNavigate } from 'react-router-dom';
import { API } from '../../service/api';
import { DataContext } from '../../context/DataProvider';

const Component = styled(Box)`
    width: 400px;
    margin: auto;
    box-shadow: 5px 2px 5px 2px rgb(0 0 0 / 0.6);
`;

const Image = styled('img')({
    width: 100,
    display: 'flex',
    margin: 'auto',
    padding: '50px 0 0'
});

const Wrapper = styled(Box)`
    padding: 25px 35px;
    display: flex;
    flex: 1;
    overflow: auto;
    flex-direction: column;
    & > div, & > button, & > p {
        margin-top: 20px;
    }
`;

const LoginButton = styled(Button)`
    text-transform: none;
    background: #FB641B;
    color: #fff;
    height: 48px;
    border-radius: 2px;
`;

const SignupButton = styled(Button)`
    text-transform: none;
    background: #fff;
    color: #2874f0;
    height: 48px;
    border-radius: 2px;
    box-shadow: 0 2px 4px 0 rgb(0 0 0 / 20%);
`;

const Text = styled(Typography)`
    color: #878787;
    font-size: 12px;
`;

const Error = styled(Typography)`
    font-size: 10px;
    color: #ff6161;
    line-height: 0;
    margin-top: 10px;
    font-weight: 600;
`;

const loginInitialValues = {
    username: '',
    password: ''
};

const signupInitialValues = {
    name: '',
    username: '',
    password: ''
};

const Login = ({ isUserAuthenticated }) => {
    const [login, setLogin] = useState(loginInitialValues);
    const [signup, setSignup] = useState(signupInitialValues);
    const [error, showError] = useState('');
    const [account, toggleAccount] = useState('login');

    const navigate = useNavigate();
    const { setAccount } = useContext(DataContext);

    const imageURL = 'https://www.sesta.it/wp-content/uploads/2021/03/logo-blog-sesta-trasparente.png';

    useEffect(() => {
        showError('');
    }, [login]);

    const onValueChange = (e) => {
        setLogin({ ...login, [e.target.name]: e.target.value });
    };

    const onInputChange = (e) => {
        setSignup({ ...signup, [e.target.name]: e.target.value });
    };

     const loginUser = async (username, password) => {
    try {
        // Find user by username
        const user = await User.findOne({ username });
        if (!user) {
            return { isSuccess: false, msg: 'Username does not exist' };
        }

        // Check if password matches
        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) {
            return { isSuccess: false, msg: 'Password does not match' };
        }

        // Generate access token
        const accessToken = jwt.sign(user.toJSON(), process.env.ACCESS_SECRET_KEY, { expiresIn: '15m' });
        // Generate refresh token
        const refreshToken = jwt.sign(user.toJSON(), process.env.REFRESH_SECRET_KEY);

        // Save refresh token to database
        const newToken = new Token({ token: refreshToken });
        await newToken.save();

        // Return successful login response with tokens and user details
        return { isSuccess: true, data: { accessToken, refreshToken, name: user.name, username: user.username } };
    } catch (error) {
        console.error('Error while logging in user:', error);
        throw error; // Propagate the error to be handled by the caller
    }
};

    

    const signupUser = async () => {
        try {
            let response = await API.userSignup(signup);
            if (response.isSuccess) {
                showError('');
                setSignup(signupInitialValues);
                toggleAccount('login');
            } else {
                showError(response.msg || 'Something went wrong! Please try again later.');
            }
        } catch (error) {
            showError('Something went wrong! Please try again later.');
            console.log(error);
        }
    };

    const toggleSignup = () => {
        toggleAccount(account === 'signup' ? 'login' : 'signup');
    };

    return (
        <Component>
            <Box>
                <Image src={imageURL} alt="blog" />
                {account === 'login' ? (
                    <Wrapper>
                        <TextField
                            variant="standard"
                            value={login.username}
                            onChange={onValueChange}
                            name="username"
                            label="Enter Username"
                        />
                        <TextField
                            variant="standard"
                            value={login.password}
                            onChange={onValueChange}
                            name="password"
                            label="Enter Password"
                            type="password"
                        />

                        {error && <Error>{error}</Error>}

                        <LoginButton variant="contained" onClick={loginUser}>
                            Login
                        </LoginButton>
                        <Text style={{ textAlign: 'center' }}>OR</Text>
                        <SignupButton onClick={toggleSignup} style={{ marginBottom: 50 }}>
                            Create an account
                        </SignupButton>
                    </Wrapper>
                ) : (
                    <Wrapper>
                        <TextField
                            variant="standard"
                            value={signup.name}
                            onChange={onInputChange}
                            name="name"
                            label="Enter Name"
                        />
                        <TextField
                            variant="standard"
                            value={signup.username}
                            onChange={onInputChange}
                            name="username"
                            label="Enter Username"
                        />
                        <TextField
                            variant="standard"
                            value={signup.password}
                            onChange={onInputChange}
                            name="password"
                            label="Enter Password"
                            type="password"
                        />

                        {error && <Error>{error}</Error>}

                        <SignupButton onClick={signupUser}>Signup</SignupButton>
                        <Text style={{ textAlign: 'center' }}>OR</Text>
                        <LoginButton variant="contained" onClick={toggleSignup}>
                            Already have an account
                        </LoginButton>
                    </Wrapper>
                )}
            </Box>
        </Component>
    );
};

export default Login;
