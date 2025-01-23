import { useParams } from 'react-router-dom'
import {
  Chart as ChartJS,
  CategoryScale,
  LinearScale,
  BarElement,
  Title,
  Tooltip,
  Legend
} from 'chart.js'
import { Bar } from 'react-chartjs-2'

ChartJS.register(
  CategoryScale,
  LinearScale,
  BarElement,
  Title,
  Tooltip,
  Legend
)

const AgentDetails = () => {
  const { id } = useParams<{ id: string }>()

  // Dummy data for now
  const agentData = {
    id: id,
    firstName: 'John',
    lastName: 'Doe',
    email: 'john.doe@company.com',
    skills: ['technical', 'billing', 'customer service', 'api'],
    timezone: 'America/New_York',
    assignedTickets: 5,
    responseTime: '2.5 hours',
    resolutionRate: '85%',
    customerSatisfaction: '4.2/5',
    // Dummy ticket completion data for the last 7 days
    ticketCompletions: [
      { date: '01/17', count: 8 },
      { date: '01/18', count: 6 },
      { date: '01/19', count: 9 },
      { date: '01/20', count: 7 },
      { date: '01/21', count: 5 },
      { date: '01/22', count: 8 },
      { date: '01/23', count: 7 },
    ],
    // Dummy team average data
    teamAverages: [
      { date: '01/17', count: 6.5 },
      { date: '01/18', count: 6.2 },
      { date: '01/19', count: 6.8 },
      { date: '01/20', count: 6.4 },
      { date: '01/21', count: 6.1 },
      { date: '01/22', count: 6.3 },
      { date: '01/23', count: 6.5 },
    ]
  }

  const chartData = {
    labels: agentData.ticketCompletions.map(d => d.date),
    datasets: [
      {
        label: 'Agent Completions',
        data: agentData.ticketCompletions.map(d => d.count),
        backgroundColor: 'rgba(45, 212, 191, 0.5)',
        borderColor: 'rgb(45, 212, 191)',
        borderWidth: 1,
      },
      {
        label: 'Team Average',
        data: agentData.teamAverages.map(d => d.count),
        backgroundColor: 'rgba(99, 102, 241, 0.5)',
        borderColor: 'rgb(99, 102, 241)',
        borderWidth: 1,
      }
    ]
  }

  const chartOptions = {
    responsive: true,
    plugins: {
      legend: {
        position: 'top' as const,
      },
      title: {
        display: true,
        text: 'Daily Ticket Completions',
      },
    },
    scales: {
      y: {
        beginAtZero: true,
        grid: {
          color: 'rgba(0, 0, 0, 0.1)',
        },
        title: {
          display: true,
          text: 'Tickets Completed'
        }
      },
      x: {
        grid: {
          color: 'rgba(0, 0, 0, 0.1)',
        }
      }
    }
  }

  return (
    <div className="container mx-auto px-4 py-8">
      <div className="bg-white shadow-md rounded-lg overflow-hidden">
        {/* Header Section */}
        <div className="border-b border-gray-200 bg-gray-50 p-6">
          <div className="flex justify-between items-start mb-4">
            <div>
              <h1 className="text-2xl font-bold text-gray-900">
                {agentData.firstName} {agentData.lastName}
              </h1>
              <p className="text-sm text-gray-500 mt-1">{agentData.email}</p>
              <p className="text-sm text-gray-500">{agentData.timezone}</p>
            </div>
          </div>
          
          {/* Skills Badges */}
          <div className="mt-4">
            <p className="text-sm font-medium text-gray-500 mb-2">Skills</p>
            <div className="flex flex-wrap gap-2">
              {agentData.skills.map((skill) => (
                <span
                  key={skill}
                  className="inline-flex items-center px-3 py-1.5 rounded-full text-sm font-medium bg-teal-100 text-teal-800"
                >
                  {skill}
                </span>
              ))}
            </div>
          </div>
        </div>

        {/* Quick Stats */}
        <div className="grid grid-cols-4 gap-4 p-6 border-b border-gray-200">
          <div className="bg-gray-50 rounded-lg p-4">
            <p className="text-sm font-medium text-gray-500">Assigned Tickets</p>
            <p className="mt-1 text-2xl font-semibold text-gray-900">{agentData.assignedTickets}</p>
          </div>
          <div className="bg-gray-50 rounded-lg p-4">
            <p className="text-sm font-medium text-gray-500">Response Time</p>
            <p className="mt-1 text-2xl font-semibold text-gray-900">{agentData.responseTime}</p>
          </div>
          <div className="bg-gray-50 rounded-lg p-4">
            <p className="text-sm font-medium text-gray-500">Resolution Rate</p>
            <p className="mt-1 text-2xl font-semibold text-gray-900">{agentData.resolutionRate}</p>
          </div>
          <div className="bg-gray-50 rounded-lg p-4">
            <p className="text-sm font-medium text-gray-500">Customer Satisfaction</p>
            <p className="mt-1 text-2xl font-semibold text-gray-900">{agentData.customerSatisfaction}</p>
          </div>
        </div>

        {/* Chart Section */}
        <div className="p-6">
          <div className="bg-white rounded-lg">
            <div className="h-[400px]">
              <Bar options={chartOptions} data={chartData} />
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}

export default AgentDetails
