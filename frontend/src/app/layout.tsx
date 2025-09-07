import type { Metadata } from 'next'
import './globals.css'
import { AuthProvider } from '@/components/AuthProvider'
import Navigation from '@/components/Navigation'

export const metadata: Metadata = {
  title: 'OAuth POC App',
  description: 'Google OAuth integration test',
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en">
      <body>
        <AuthProvider>
          <Navigation />
          <main className="container mx-auto p-4">
            {children}
          </main>
        </AuthProvider>
      </body>
    </html>
  )
}