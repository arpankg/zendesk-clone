import { Routes, Route } from 'react-router-dom'
import Support from './pages/Support'

function App() {
  return (
    <Routes>
      <Route path="/" element={
        <div className="min-h-screen flex items-center justify-center bg-gray-100">
          <h1 className="text-4xl font-bold text-gray-800">
            Hello World
          </h1>
        </div>
      } />
      <Route path="/support" element={<Support />} />
    </Routes>
  )
}

export default App
