import { GoogleLoginButton } from '@/components/GoogleLoginButton'

export default function Home() {
  return (
    <div className="min-h-screen flex items-center justify-center">
      <div className="text-center">
        <h1 className="text-4xl font-bold mb-8">OAuth POC App</h1>
        <p className="text-xl mb-8">Test Google OAuth integration</p>
        <GoogleLoginButton />
      </div>
    </div>
  )
}