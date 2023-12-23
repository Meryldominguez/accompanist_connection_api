import React from 'react'
import AppBar from '@mui/material/AppBar'
import Grid from '@mui/material/Grid'
import SignupLoginButtonGroup from './SignupLoginButtonGroup'
import { Typography } from '@mui/material'

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
      component="footer">
      <Grid container justifyContent="space-around" sx={{ flexGrow: 1 }}>
        <Grid item>
          <Grid container flexDirection="column" alignItems="center">
            <Grid item>
              <Typography>Hello</Typography>
            </Grid>
            <Grid item>
              <SignupLoginButtonGroup baseColor="secondary" />
            </Grid>
          </Grid>
        </Grid>
        <Grid item>
          <SignupLoginButtonGroup baseColor="secondary" />
        </Grid>
        <Grid item>
          <SignupLoginButtonGroup baseColor="secondary" />
        </Grid>
      </Grid>
    </AppBar>
  )
}

export default Footer
