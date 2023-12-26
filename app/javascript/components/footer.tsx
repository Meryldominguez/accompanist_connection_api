import AppBar from '@mui/material/AppBar'
import Grid from '@mui/material/Grid'
import Typography from '@mui/material/Typography'
import LogoHeader from './LogoHeader'
import SignupLoginButtonGroup from './SignupLoginButtonGroup'

const Footer = () => {
  return (
    <AppBar
      position="static"
      sx={{
        display: 'flex',
        flexDirection: 'column',
        minHeight: 4,
        bottom: 0,
      }}
      component="footer"
    >
      <Grid container justifyContent="space-around" my={3}>
        <Grid item>
          <Grid container flexDirection="column" alignItems="stretch">
            <Grid item>
              <LogoHeader size={35} display={{ xs: 'flex' }} />
            </Grid>
            <Grid item display={{ xs: 'flex' }}>
              <SignupLoginButtonGroup size="large" baseColor="secondary" />
            </Grid>
          </Grid>
        </Grid>
        <Grid item>
          <Grid container flexDirection="column" alignItems="stretch">
            <Grid item>
              <Typography>Contact us:</Typography>
            </Grid>
            <Grid item>
              <Typography>OUR EMAIL</Typography>
            </Grid>
            <Grid item>
              <Typography> SOCIAL MEDIA BAR</Typography>
            </Grid>
          </Grid>
        </Grid>
        <Grid item display={{ xs: 'none', sm: 'flex' }}>
          <Grid container flexDirection="column" alignItems="stretch">
            <Grid item>
              <LogoHeader size={35} display={{ xs: 'flex' }} />
            </Grid>
            <Grid item display={{ xs: 'none', sm: 'flex' }}>
              <SignupLoginButtonGroup size="large" baseColor="secondary" />
            </Grid>
          </Grid>
        </Grid>
      </Grid>
    </AppBar>
  )
}

export default Footer
