import { Navigate } from 'react-router-dom'
import { Root } from './components/Root'

interface Route {
  path?: string
  Component?: () => JSX.Element
  element?: JSX.Element
  children?: Route[]
}

type Routes = Route[]

const loginRoutes: Routes = [
  {
    path: 'login',
    Component: () => <h1>Login Index</h1>,
  },
]
const authRoutes: Routes = [
  {
    path: '/',
    Component: () => <h1>test</h1>,
  },
]
const publicRoutes: Routes = [
  {
    path: '/info',
    Component: () => <h1>info!</h1>,
  },
]

const generateRoutes = (isAuth: boolean) => [
  {
    element: <Root />,
    children: isAuth ? [...authRoutes, ...publicRoutes] : [...loginRoutes, ...publicRoutes],
  },
  {
    path: '*',
    Component: () => <Navigate to={isAuth ? '/' : '/login'} replace />,
  },
]

export { generateRoutes }
