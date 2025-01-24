import { Link } from 'react-router-dom';
import { TicketIcon, BookOpenIcon, ChatBubbleLeftRightIcon, ClipboardDocumentCheckIcon } from '@heroicons/react/24/outline';

const actions = [
  {
    title: 'Submit Ticket',
    description: 'Create a new support ticket for your issue',
    icon: TicketIcon,
    to: '/support',
  },
  {
    title: 'View Tickets',
    description: 'Check the status of your existing tickets',
    icon: ClipboardDocumentCheckIcon,
    to: '/customer-dashboard',
  },
  {
    title: 'Knowledge Base',
    description: 'Browse our comprehensive documentation',
    icon: BookOpenIcon,
    to: '/knowledge-base',
  },
  {
    title: 'Contact Support',
    description: 'Get in touch with our support team',
    icon: ChatBubbleLeftRightIcon,
    to: '/support',
  },
];

export const QuickActions = () => {
  return (
    <div className="py-12 bg-white">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="text-center">
          <h2 className="text-3xl font-bold text-gray-900">How can we help you?</h2>
          <p className="mt-4 text-lg text-gray-500">
            Choose from the options below to get started
          </p>
        </div>

        <div className="mt-10">
          <div className="grid grid-cols-1 gap-8 sm:grid-cols-2 lg:grid-cols-4">
            {actions.map((action) => (
              <Link
                key={action.title}
                to={action.to}
                className="relative group bg-white p-6 focus-within:ring-2 focus-within:ring-inset focus-within:ring-black rounded-lg overflow-hidden hover:shadow-lg transition-shadow duration-300"
              >
                <div>
                  <span className="rounded-lg inline-flex p-3 bg-[#345fea]/10 text-[#345fea] ring-4 ring-white">
                    <action.icon className="h-6 w-6" aria-hidden="true" />
                  </span>
                </div>
                <div className="mt-8">
                  <h3 className="text-lg font-medium">
                    <span className="absolute inset-0" aria-hidden="true" />
                    {action.title}
                  </h3>
                  <p className="mt-2 text-sm text-gray-500">
                    {action.description}
                  </p>
                </div>
              </Link>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
};
