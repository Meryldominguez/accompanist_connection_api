import { yupResolver } from '@hookform/resolvers/yup'
import { Button, Stack, Typography } from '@mui/material'
import TextField from '@mui/material/TextField/TextField'
import { FunctionComponent } from 'react'
import { Controller, SubmitHandler, useForm } from 'react-hook-form'
import * as yup from 'yup'
import useCreateUser from '../hooks/useCreateUser'

interface SignupFormInput {
  firstName: string
  lastName: string
  email: string
  password: string
  confirmPassword: string
}

const schema = yup
  .object({
    firstName: yup.string().required('First name is required'),
    lastName: yup.string().required('Last name is required'),
    email: yup.string().email().required('Email is required'),
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
  const createUser = useCreateUser()

  const onSubmit: SubmitHandler<SignupFormInput> = (data) => {
    createUser.mutate({
      first_name: data.firstName,
      last_name: data.lastName,
      email: data.email,
      password: data.password,
    })
  }

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <Stack>
        <Typography variant="h2" align="center" margin={1}>
          Signup
        </Typography>
        <Stack direction="row" spacing={1}>
          <Controller
            name="firstName"
            control={control}
            render={({ field }) => (
              <TextField
                color="secondary"
                id="outlined-required"
                label="First name"
                autoComplete="current-first-name"
                error={Boolean(errors.firstName)}
                helperText={errors.firstName?.message}
                sx={{ minHeight: '80px' }}
                {...field}
              />
            )}
          />
          <Controller
            name="lastName"
            control={control}
            render={({ field }) => (
              <TextField
                color="secondary"
                id="outlined-required"
                label="Last Name"
                autoComplete="current-last-name"
                error={Boolean(errors.lastName)}
                helperText={errors.lastName?.message}
                sx={{ minHeight: '80px' }}
                {...field}
              />
            )}
          />
        </Stack>

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
