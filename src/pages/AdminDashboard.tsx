import { useState } from 'react'

// Dummy data
const dummyAgents = [
  {
    id: '1',
    firstName: 'John',
    lastName: 'Doe',
    email: 'john.doe@company.com',
    skills: ['technical', 'billing'],
    timezone: 'America/New_York',
    assignedTickets: 5
  },
  {
    id: '2',
    firstName: 'Jane',
    lastName: 'Smith',
    email: 'jane.smith@company.com',
    skills: ['customer service', 'technical'],
    timezone: 'America/Los_Angeles',
    assignedTickets: 3
  },
  {
    id: '3',
    firstName: 'Mike',
    lastName: 'Johnson',
    email: 'mike.johnson@company.com',
    skills: ['billing', 'sales'],
    timezone: 'Europe/London',
    assignedTickets: 7
  }
]

const AdminDashboard = () => {
  const [agents] = useState(dummyAgents)

  return (
    <div className="container mx-auto px-4 py-8">
      <h1 className="text-2xl font-bold mb-6">Customer Support Agents</h1>
      <div className="bg-white shadow-md rounded-lg overflow-hidden">
        <table className="min-w-full divide-y divide-gray-200">
          <thead className="bg-gray-50">
            <tr>
              <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Name</th>
              <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Email</th>
              <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Skills</th>
              <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Timezone</th>
              <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Assigned Tickets</th>
            </tr>
          </thead>
          <tbody className="divide-y divide-gray-200">
            {agents.map((agent) => (
              <tr key={agent.id}>
                <td className="px-6 py-4">
                  {agent.firstName} {agent.lastName}
                </td>
                <td className="px-6 py-4">{agent.email}</td>
                <td className="px-6 py-4">
                  <div className="flex gap-1">
                    {agent.skills.map((skill) => (
                      <span key={skill} className="px-2 py-1 bg-blue-100 text-blue-800 rounded-full text-xs">
                        {skill}
                      </span>
                    ))}
                  </div>
                </td>
                <td className="px-6 py-4">{agent.timezone}</td>
                <td className="px-6 py-4">{agent.assignedTickets}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  )
}

export default AdminDashboard
