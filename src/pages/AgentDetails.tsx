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
    skills: ['technical', 'billing'],
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
        backgroundColor: 'rgba(53, 162, 235, 0.5)',
        borderColor: 'rgb(53, 162, 235)',
        borderWidth: 1,
      },
      {
        label: 'Team Average',
        data: agentData.teamAverages.map(d => d.count),
        backgroundColor: 'rgba(255, 99, 132, 0.5)',
        borderColor: 'rgb(255, 99, 132)',
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
        title: {
          display: true,
          text: 'Tickets Completed'
        }
      }
    }
  }

  return (
    <div className="container mx-auto px-4 py-8">
      <h1 className="text-2xl font-bold mb-6">Agent Details</h1>
      <div className="bg-white shadow-md rounded-lg p-6">
        <div className="grid grid-cols-2 gap-4 mb-8">
          <div>
            <h2 className="text-lg font-semibold mb-4">Basic Information</h2>
            <p><span className="font-medium">Name:</span> {agentData.firstName} {agentData.lastName}</p>
            <p><span className="font-medium">Email:</span> {agentData.email}</p>
            <p><span className="font-medium">Timezone:</span> {agentData.timezone}</p>
            <p><span className="font-medium">Skills:</span></p>
            <div className="flex gap-1 mt-1">
              {agentData.skills.map((skill) => (
                <span key={skill} className="px-2 py-1 bg-blue-100 text-blue-800 rounded-full text-xs">
                  {skill}
                </span>
              ))}
            </div>
          </div>
          <div>
            <h2 className="text-lg font-semibold mb-4">Performance Metrics</h2>
            <p><span className="font-medium">Current Assigned Tickets:</span> {agentData.assignedTickets}</p>
            <p><span className="font-medium">Average Response Time:</span> {agentData.responseTime}</p>
            <p><span className="font-medium">Resolution Rate:</span> {agentData.resolutionRate}</p>
            <p><span className="font-medium">Customer Satisfaction:</span> {agentData.customerSatisfaction}</p>
          </div>
        </div>
        
        <div className="mt-8">
          <h2 className="text-lg font-semibold mb-4">Ticket Completion Trends</h2>
          <div className="h-[400px]">
            <Bar options={chartOptions} data={chartData} />
          </div>
        </div>
      </div>
    </div>
  )
}

export default AgentDetails
