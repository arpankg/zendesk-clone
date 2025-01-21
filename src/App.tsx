import { Routes, Route } from 'react-router-dom'
import Support from './pages/Support'
import SignUp from './pages/SignUp'
import CustomerDashboard from './pages/CustomerDashboard'

function App() {
  return (
    <Routes>
      <Route path="/" element={
        <div className="min-h-screen flex items-center justify-center bg-gray-100">
          <div className="text-center">
            <h1 className="text-4xl font-bold text-gray-800 mb-4">
              Welcome to Support Portal
            </h1>
            <div className="space-x-4">
              <a href="/signup" className="text-teal-600 hover:text-teal-800">Sign Up</a>
              <a href="/support" className="text-teal-600 hover:text-teal-800">Get Support</a>
            </div>
          </div>
        </div>
      } />
      <Route path="/support" element={<Support />} />
      <Route path="/signup" element={<SignUp />} />
      <Route path="/customer-dashboard" element={<CustomerDashboard />} />
    </Routes>
  )
}

export default App
