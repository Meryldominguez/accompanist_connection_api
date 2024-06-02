import Box from '@mui/material/Box/Box'
import Modal from '@mui/material/Modal/Modal'
import Typography from '@mui/material/Typography/Typography'
import useTheme from '@mui/material/styles/useTheme'
import { FunctionComponent } from 'react'
import LoginForm from './LoginForm'
import SignupForm from './SignupForm'

const LoginModal: FunctionComponent<{
  open: boolean
  signupMode: boolean
  toggleSignupMode: () => void
  handleClose: () => void
}> = ({ open, toggleSignupMode, signupMode = false, handleClose }) => {
  const theme = useTheme()
  return (
    <Modal
      open={open}
      onClose={handleClose}
      aria-labelledby="modal-modal-title"
      aria-describedby="modal-modal-description"
    >
      <Box
        sx={{
          position: 'absolute',
          top: '50%',
          left: '50%',
          transform: 'translate(-50%, -50%)',
          bgcolor: 'background.paper',
          border: '2px solid' + theme.palette.secondary.dark,
          borderRadius: '10px',
          minWidth: '300px',
          minHeight: '400px',
          display: 'flex',
          flexDirection: 'column',
          justifyContent: 'space-between',
          p: 4,
        }}
      >
        {signupMode ? <SignupForm /> : <LoginForm />}
        <Typography onClick={toggleSignupMode} align="center">
          {signupMode
            ? 'Have an account already? Click to Login here'
            : "Don't have an account? Click to Sign up here!"}
        </Typography>
      </Box>
    </Modal>
  )
}

export default LoginModal
