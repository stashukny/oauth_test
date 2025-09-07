'use client'

import { ProtectedRoute } from '@/components/ProtectedRoute'
import { useAuth } from '@/components/AuthProvider'

export default function Profile() {
  const { user } = useAuth()

  return (
    <ProtectedRoute>
      <div className="max-w-4xl mx-auto">
        <h1 className="text-3xl font-bold mb-6">Profile</h1>
        <div className="bg-white shadow rounded-lg p-6 mb-6">
          <h2 className="text-xl font-semibold mb-4">✅ Authentication Persisted</h2>
          <p className="text-lg mb-4">This is another protected page to test authentication persistence.</p>
          {user && (
            <div className="bg-blue-50 border border-blue-200 rounded p-4">
              <div className="flex items-center space-x-4">
                <img 
                  src={user.picture} 
                  alt={user.name}
                  className="w-16 h-16 rounded-full"
                />
                <div>
                  <h3 className="font-semibold text-blue-800">{user.name}</h3>
                  <p className="text-blue-600">{user.email}</p>
                  <p className="text-xs text-blue-500">Session active - OAuth working correctly!</p>
                </div>
              </div>
            </div>
          )}
        </div>
      </div>
    </ProtectedRoute>
  )
}