import Box from '@mui/material/Box'
import Button, { ButtonOwnProps } from '@mui/material/Button'
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
  return (
    <Box
      sx={{
        display: display,
        justifyContent: 'space-between',
        flexGrow: 1,
        my: 1,
      }}
    >
      <Button
        onClick={() => {}}
        sx={{ mx: 1, display: 'block', textWrap: 'nowrap', flexGrow: 1 }}
        color={baseColor == 'primary' ? 'secondary' : 'primary'}
        variant="contained"
        size={size}
      >
        LOGIN
      </Button>
      <Button
        onClick={() => {}}
        sx={{ mx: 1, display: 'block', textWrap: 'nowrap', flexGrow: 1 }}
        variant="outlined"
        color={baseColor}
        size={size}
      >
        SIGN UP
      </Button>
    </Box>
  )
}

export default SignupLoginButtonGroup
