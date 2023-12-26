import GraphicEqIcon from '@mui/icons-material/GraphicEq'
import Grid from '@mui/material/Grid'
import Typography from '@mui/material/Typography'
import { BreakPointsProps } from './types/stylingTypes'

type LogoHeaderProps = {
  display?: BreakPointsProps
  size?: number
}

const LogoHeader = ({ display = { xs: 'none', md: 'flex' }, size = 40 }: LogoHeaderProps) => {
  return (
    <Grid
      container
      flexDirection="row"
      flexWrap="nowrap"
      alignItems="center"
      href="#app-bar-with-responsive-menu"
      component="a"
      spacing={1}
      marginTop={0}
    >
      <Grid item>
        <GraphicEqIcon sx={{ display: display, fontSize: size + 10 }} />
      </Grid>
      <Grid item padding={1}>
        <Typography
          noWrap
          sx={{
            mr: 2,
            display: display,
            fontFamily: 'monospace',
            fontWeight: 900,
            letterSpacing: '.3rem',
            color: 'inherit',
            textDecoration: 'none',
            fontSize: size,
          }}
        >
          ACC CON
        </Typography>
      </Grid>
    </Grid>
  )
}

export default LogoHeader
