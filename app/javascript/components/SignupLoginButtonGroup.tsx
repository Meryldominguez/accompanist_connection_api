import Box from '@mui/material/Box'
import Button, { ButtonOwnProps } from '@mui/material/Button'
import { useState } from 'react'
import LoginModal from './LoginModal'
import { BreakPointsProps } from './types/stylingTypes'

type SignupLoginButtonGroupProps = {
  baseColor?: 'primary' | 'secondary'
  display?: BreakPointsProps
  size?: ButtonOwnProps['size']
}

const SignupLoginButtonGroup = ({
  baseColor = 'primary',
  display = { xs: 'flex' },
  size = 'large',
}: SignupLoginButtonGroupProps) => {
  const [openModal, setOpenModal] = useState(false)
  const [signupMode, setSignupMode] = useState(false)

  const handleOpen = (mode: 'signup' | 'login') => {
    if (mode == 'signup') {
      setSignupMode(true)
    }
    setOpenModal(true)
  }

  const handleClose = () => {
    setSignupMode(false)
    setOpenModal(false)
  }
  const toggleSignupMode = () => {
    if (signupMode) {
      setSignupMode(false)
    } else {
      setSignupMode(true)
    }
  }
  return (
    <>
      <Box
        sx={{
          display: display,
          justifyContent: 'space-between',
          flexGrow: 1,
          my: 1,
        }}
      >
        <Button
          onClick={() => handleOpen('login')}
          sx={{ mx: 1, display: 'block', textWrap: 'nowrap', flexGrow: 1 }}
          color={baseColor == 'primary' ? 'secondary' : 'primary'}
          variant="contained"
          size={size}
        >
          LOGIN
        </Button>
        <Button
          onClick={() => handleOpen('signup')}
          sx={{ mx: 1, display: 'block', textWrap: 'nowrap', flexGrow: 1 }}
          variant="outlined"
          color={baseColor}
          size={size}
        >
          SIGN UP
        </Button>
      </Box>
      <LoginModal
        open={openModal}
        signupMode={signupMode}
        toggleSignupMode={toggleSignupMode}
        handleClose={handleClose}
      />
    </>
  )
}

export default SignupLoginButtonGroup
