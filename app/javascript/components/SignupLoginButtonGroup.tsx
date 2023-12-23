import React from 'react'

import Box from '@mui/material/Box'
import Button, { ButtonOwnProps } from '@mui/material/Button'

type BreakPointsProps = {
  xs?: 'flex' | 'none'
  sm?: 'flex' | 'none'
  md?: 'flex' | 'none'
  lg?: 'flex' | 'none'
  xl?: 'flex' | 'none'
}

type SignupLoginButtonGroupProps = {
  baseColor?: 'primary' | 'secondary'
  breakPoints?: BreakPointsProps
  size?: ButtonOwnProps['size']
}

const SignupLoginButtonGroup = ({
  baseColor = 'primary',
  breakPoints = { xs: 'none', sm: 'flex' },
  size = 'large',
}: SignupLoginButtonGroupProps) => {
  return (
    <Box
      sx={{
        paddingLeft: 3,
        display: breakPoints,
        justifyContent: 'space-around',
      }}>
      <Button
        onClick={() => {}}
        sx={{ my: 2, mx: 1, display: 'block' }}
        color={baseColor == 'primary' ? 'secondary' : 'primary'}
        variant="contained"
        size={size}>
        LOGIN
      </Button>
      <Button
        onClick={() => {}}
        sx={{ my: 2, mx: 1, display: 'block' }}
        variant="outlined"
        color={baseColor}
        size={size}>
        SIGN UP
      </Button>
    </Box>
  )
}

export default SignupLoginButtonGroup
