import { yupResolver } from '@hookform/resolvers/yup'
import { Button, Stack, Typography } from '@mui/material'
import TextField from '@mui/material/TextField/TextField'
import { FunctionComponent } from 'react'
import { Controller, SubmitHandler, useForm } from 'react-hook-form'
import * as yup from 'yup'

interface SignupFormInput {
  email: string
  password: string
  confirmPassword: string
}

const schema = yup
  .object({
    email: yup.string().email().required(),
    password: yup
      .string()
      .min(6, 'Password must be over 6 characters long')
      .max(20, 'Password must be less than 20 characters')
      .required(),
    confirmPassword: yup
      .string()
      .test('passwords-match', 'Passwords must match', function (value) {
        return this.parent.password === value
      })
      .required('Passwords must match'),
  })
  .required()

const SignupForm: FunctionComponent = () => {
  const {
    control,
    handleSubmit,
    formState: { errors },
  } = useForm({ resolver: yupResolver(schema) })

  const onSubmit: SubmitHandler<SignupFormInput> = (data) => {
    console.log(data)
  }

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <Stack>
        <Typography variant="h2" align="center">
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
        <Controller
          name="confirmPassword"
          control={control}
          render={({ field }) => (
            <TextField
              id="outlined-confirm-password-input"
              color="secondary"
              label="Confirm Password"
              type="password"
              error={Boolean(errors.confirmPassword)}
              helperText={errors.confirmPassword?.message}
              autoComplete="current-confirm-password"
              sx={{ minHeight: '80px' }}
              {...field}
            />
          )}
        />
        <Button variant="outlined" color="primary" size="large" type="submit" sx={{ margin: 2 }}>
          Signup
        </Button>
      </Stack>
    </form>
  )
}

export default SignupForm
