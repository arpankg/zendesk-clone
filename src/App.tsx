import { Routes, Route } from 'react-router-dom'
import Support from './pages/Support'
import CustomerSignUp from './pages/CustomerSignUp'
import CustomerLogin from './pages/CustomerLogin'
import CustomerDashboard from './pages/CustomerDashboard'
import CustomerTicketDetails from './pages/CustomerTicketDetails'
import EmployeeDashboard from './pages/EmployeeDashboard'
import EmployeeLogin from './pages/EmployeeLogin'
import EmployeeSignUp from './pages/EmployeeSignUp'
import TicketDetails from './pages/TicketDetails'
import AdminDashboard from './pages/AdminDashboard'
import AgentDetails from './pages/AgentDetails'
import KnowledgeBase from './pages/KnowledgeBase'
import { NavigationBar } from './components/home/NavigationBar'
import { HeroSection } from './components/home/HeroSection'
import { QuickActions } from './components/home/QuickActions'
import { SupportFeatures } from './components/home/SupportFeatures'

function App() {
  return (
    <Routes>
      <Route path="/" element={
        <div className="min-h-screen bg-white">
          <NavigationBar />
          <main>
            <HeroSection />
            <QuickActions />
            <SupportFeatures />
          </main>
        </div>
      } />
      <Route path="/support" element={<Support />} />
      <Route path="/customer-signup" element={<CustomerSignUp />} />
      <Route path="/customer-login" element={<CustomerLogin />} />
      <Route path="/customer-dashboard" element={<CustomerDashboard />} />
      <Route path="/customer/ticket/:id" element={<CustomerTicketDetails />} />
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
