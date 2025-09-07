'use client'

import { useAuth } from './AuthProvider'
import { useEffect } from 'react'

declare global {
  interface Window {
    google: any
  }
}

export function GoogleLoginButton() {
  const { user, login, logout } = useAuth()

  useEffect(() => {
    if (typeof window !== 'undefined') {
      const script = document.createElement('script')
      script.src = 'https://accounts.google.com/gsi/client'
      script.async = true
      script.defer = true
      document.body.appendChild(script)

      script.onload = () => {
        if (window.google) {
          window.google.accounts.id.initialize({
            client_id: process.env.NEXT_PUBLIC_GOOGLE_CLIENT_ID,
            callback: (response: any) => {
              login(response.credential)
            }
          })

          window.google.accounts.id.renderButton(
            document.getElementById('google-signin-button'),
            {
              theme: 'outline',
              size: 'large',
              width: '300'
            }
          )
        }
      }

      return () => {
        document.body.removeChild(script)
      }
    }
  }, [login])

  if (user) {
    return (
      <div className="text-center">
        <div className="mb-4">
          <img 
            src={user.picture} 
            alt={user.name} 
            className="w-16 h-16 rounded-full mx-auto mb-2"
          />
          <h2 className="text-xl font-semibold">Welcome, {user.name}!</h2>
          <p className="text-gray-600">{user.email}</p>
        </div>
        <button
          onClick={logout}
          className="bg-red-500 text-white px-4 py-2 rounded hover:bg-red-600"
        >
          Logout
        </button>
      </div>
    )
  }

  return <div id="google-signin-button" className="flex justify-center"></div>
}