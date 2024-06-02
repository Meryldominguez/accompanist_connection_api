import { yupResolver } from '@hookform/resolvers/yup'
import { Button, Stack, Typography } from '@mui/material'
import TextField from '@mui/material/TextField/TextField'
import { FunctionComponent } from 'react'
import { Controller, SubmitHandler, useForm } from 'react-hook-form'
import * as yup from 'yup'

interface LoginFormInput {
  email: string
  password: string
}

const schema = yup
  .object({
    email: yup.string().email().required(),
    password: yup.string().required(),
  })
  .required()

const LoginForm: FunctionComponent = () => {
  const {
    control,
    handleSubmit,
    formState: { errors },
  } = useForm({ resolver: yupResolver(schema) })

  const onSubmit: SubmitHandler<LoginFormInput> = (data) => {
    console.log(data)
  }

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <Stack>
        <Typography variant="h2" align="center" margin={1}>
          Login
        </Typography>
        <Controller
          name="email"
          control={control}
          render={({ field }) => (
            <TextField
              color="secondary"
              id="outlined-required"
              label="Username"
              autoComplete="current-username"
              error={Boolean(errors.email)}
              helperText={errors.email?.message}
              sx={{ minHeight: '80px' }}
              {...field}
            />
          )}
        />

        <Controller
          name="password"
          control={control}
          render={({ field }) => (
            <TextField
              id="outlined-password-input"
              color="secondary"
              label="Password"
              type="password"
              error={Boolean(errors.password)}
              helperText={errors.password?.message}
              autoComplete="current-password"
              sx={{ minHeight: '80px' }}
              {...field}
            />
          )}
        />
        <Button variant="outlined" color="primary" size="large" type="submit" sx={{ margin: 2 }}>
          Login
        </Button>
      </Stack>
    </form>
  )
}

export default LoginForm
