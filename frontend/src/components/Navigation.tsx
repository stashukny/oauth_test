'use client'

import Link from 'next/link'
import { useAuth } from './AuthProvider'

export default function Navigation() {
  const { user, logout } = useAuth()

  return (
    <nav className="bg-blue-600 text-white p-4">
      <div className="container mx-auto flex justify-between items-center">
        <Link href="/" className="text-xl font-bold">
          OAuth POC
        </Link>
        <div className="flex items-center space-x-4">
          {user ? (
            <>
              <div className="flex items-center space-x-4">
                <Link href="/dashboard" className="hover:underline">
                  Dashboard
                </Link>
                <Link href="/profile" className="hover:underline">
                  Profile
                </Link>
              </div>
              <div className="flex items-center space-x-3">
                <div className="flex items-center space-x-2">
                  <div className="w-2 h-2 bg-green-400 rounded-full"></div>
                  <span className="text-sm">Logged in as {user.name}</span>
                </div>
                <button
                  onClick={logout}
                  className="bg-red-500 hover:bg-red-600 px-3 py-1 rounded text-sm"
                >
                  Logout
                </button>
              </div>
            </>
          ) : (
            <div className="flex items-center space-x-2">
              <div className="w-2 h-2 bg-red-400 rounded-full"></div>
              <span className="text-sm">Not logged in</span>
            </div>
          )}
        </div>
      </div>
    </nav>
  )
}