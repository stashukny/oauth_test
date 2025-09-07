'use client'

import { ProtectedRoute } from '@/components/ProtectedRoute'
import { useAuth } from '@/components/AuthProvider'

export default function Dashboard() {
  const { user } = useAuth()

  return (
    <ProtectedRoute>
      <div className="max-w-4xl mx-auto">
        <h1 className="text-3xl font-bold mb-6">Dashboard</h1>
        <div className="bg-white shadow rounded-lg p-6 mb-6">
          <h2 className="text-xl font-semibold mb-4">✅ Authentication Status</h2>
          <p className="text-lg mb-4">Welcome to your dashboard! This page tests that OAuth authentication persists across navigation.</p>
          {user && (
            <div className="bg-green-50 border border-green-200 rounded p-4">
              <h3 className="font-semibold text-green-800 mb-2">User Information:</h3>
              <div className="space-y-1 text-sm">
                <p><strong>Name:</strong> {user.name}</p>
                <p><strong>Email:</strong> {user.email}</p>
                <p><strong>ID:</strong> {user.id}</p>
              </div>
            </div>
          )}
        </div>
      </div>
    </ProtectedRoute>
  )
}