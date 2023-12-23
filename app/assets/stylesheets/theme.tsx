import { createTheme } from '@mui/material/styles'

const COLORS = {
  white: '#ffffff',
  black: '#000000',
  primary: {
    main: '#961344',
    light: '#ab4269',
    dark: '#690d2f',
  },
  secondary: {
    main: '#b287a3',
    light: '#c19fb5',
    dark: '#7c5e72',
  },
  info: {
    main: '#1e88e5',
    dark: '#155fa0',
    light: '#4b9fea',
  },
  success: {
    main: '#2e7d32',
    light: '#4caf50',
    dark: '#1b5e20',
  },
  error: {
    main: '#ea0000',
    light: '#ee3333',
    dark: '#a30000',
  },
}

export const theme = createTheme({
  palette: {
    common: {
      white: COLORS.white,
      black: COLORS.black,
    },
    primary: {
      main: COLORS.primary.main,
      light: COLORS.primary.light,
      dark: COLORS.primary.dark,
      contrastText: COLORS.white,
    },
    secondary: {
      main: COLORS.secondary.main,
      light: COLORS.secondary.light,
      dark: COLORS.secondary.dark,
      contrastText: COLORS.white,
    },
    info: {
      main: COLORS.info.main,
      light: COLORS.info.light,
      dark: COLORS.info.dark,
      contrastText: COLORS.white,
    },
    success: {
      main: COLORS.success.main,
      light: COLORS.success.light,
      dark: COLORS.success.dark,
      contrastText: COLORS.white,
    },
    error: {
      main: COLORS.error.main,
      light: COLORS.error.light,
      dark: COLORS.error.dark,
      contrastText: COLORS.white,
    },
  },
  components: {
    MuiAppBar: {
      styleOverrides: {
        root: ({ ownerState }) => ({
          ...(ownerState.component === 'footer' && {
            backgroundColor: COLORS.secondary.main,
            color: COLORS.white,
          }),
        }),
      },
    },
    MuiButton: {
      styleOverrides: {
        root: ({ ownerState }) => ({
          ...(ownerState.variant === 'outlined' && {
            backgroundColor: COLORS.white,
            border: `2px solid ${COLORS.primary.main + '38'}`,
            '&:hover': {
              backgroundColor: ownerState.color,
              color: COLORS.white,
              border: `2px solid ${COLORS.white}`,
            },
          }),
        }),
      },
    },
  },
})
