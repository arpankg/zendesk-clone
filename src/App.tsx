import { Routes, Route } from 'react-router-dom'
import Support from './pages/Support'
import CustomerSignUp from './pages/CustomerSignUp'
import CustomerLogin from './pages/CustomerLogin'
import CustomerDashboard from './pages/CustomerDashboard'
import EmployeeDashboard from './pages/EmployeeDashboard'
import EmployeeLogin from './pages/EmployeeLogin'
import EmployeeSignUp from './pages/EmployeeSignUp'
import TicketDetails from './pages/TicketDetails'
import AdminDashboard from './pages/AdminDashboard'
import AgentDetails from './pages/AgentDetails'
import KnowledgeBase from './pages/KnowledgeBase'

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
              <a href="/customer-login" className="text-teal-600 hover:text-teal-800">Customer Sign In</a>
              <a href="/customer-signup" className="text-teal-600 hover:text-teal-800">Create Customer Account</a>
              <a href="/support" className="text-teal-600 hover:text-teal-800">Get Support</a>
              <a href="/employee-login" className="text-teal-600 hover:text-teal-800">Employee Portal</a>
              <a href="/admin" className="text-teal-600 hover:text-teal-800">Admin Dashboard</a>
            </div>
          </div>
        </div>
      } />
      <Route path="/support" element={<Support />} />
      <Route path="/customer-signup" element={<CustomerSignUp />} />
      <Route path="/customer-login" element={<CustomerLogin />} />
      <Route path="/customer-dashboard" element={<CustomerDashboard />} />
      <Route path="/employee-dashboard" element={<EmployeeDashboard />} />
      <Route path="/employee-dashboard/ticket/:id" element={<TicketDetails />} />
      <Route path="/employee-login" element={<EmployeeLogin />} />
      <Route path="/employee-signup" element={<EmployeeSignUp />} />
      <Route path="/admin" element={<AdminDashboard />} />
      <Route path="/admin/agent/:id" element={<AgentDetails />} />
      <Route path="/knowledge-base" element={<KnowledgeBase />} />
    </Routes>
  )
}

export default App
