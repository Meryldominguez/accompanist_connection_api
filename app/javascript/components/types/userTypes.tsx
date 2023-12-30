export interface User {
  id: string
  type: 'user'
  attributes: UserAttributes
}
export interface UserAttributes {
  id: number
  first_name: string
  last_name: string
  email: string
  full_name: string
}
