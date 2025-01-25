import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { supabase } from '../../config/supabase';
import { formatRelativeDate } from '../utils/dateUtils';
import LoadingSpinner from '../components/common/LoadingSpinner';
import ErrorMessage from '../components/common/ErrorMessage';
import { CustomerHeader } from '../components/customer/CustomerHeader';
import type { Database } from '../../config/types';

type Ticket = Database['public']['Tables']['tickets']['Row'];

interface CustomerTicketsTableProps {
  tickets: Ticket[];
}

const CustomerTicketsTable: React.FC<CustomerTicketsTableProps> = ({ tickets }) => {
  const navigate = useNavigate();

  return (
    <div className="mt-8 flow-root">
      <div className="-mx-4 -my-2 overflow-x-auto sm:-mx-6 lg:-mx-8">
        <div className="inline-block min-w-full py-2 align-middle sm:px-6 lg:px-8">
          <table className="min-w-full divide-y divide-gray-300">
            <thead>
              <tr>
                <th scope="col" className="py-3.5 pl-4 pr-3 text-left text-sm font-semibold text-gray-900 sm:pl-0">
                  Ticket
                </th>
                <th scope="col" className="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">
                  Status
                </th>
                <th scope="col" className="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">
                  Last Updated 
                </th>
                <th scope="col" className="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">
                  Customer
                </th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-200">
              {tickets.map((ticket) => (
                <tr key={ticket.id} onClick={() => navigate(`/customer/ticket/${ticket.id}`)} className="cursor-pointer hover:bg-gray-50">
                  <td className="whitespace-nowrap py-4 pl-4 pr-3 text-sm font-medium text-gray-900 sm:pl-0">
                    {ticket.title}
                  </td>
                  <td className="whitespace-nowrap px-3 py-4 text-sm">
                    <span className={`inline-flex rounded-full px-2 text-xs font-semibold leading-5 ${
                      ticket.status === 'new' ? 'bg-blue-100 text-blue-800' :
                      ticket.status === 'open' ? 'bg-yellow-100 text-yellow-800' :
                      ticket.status === 'pending' ? 'bg-purple-100 text-purple-800' :
                      'bg-green-100 text-green-800'
                    }`}>
                      {ticket.status}
                    </span>
                  </td>
                  <td className="whitespace-nowrap px-3 py-4 text-sm text-gray-500">
                    {formatRelativeDate(ticket.updated_at)}
                  </td>
                  <td className="whitespace-nowrap px-3 py-4 text-sm text-gray-500">
                    {ticket.customer_email}
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
};

const EmptyState = () => (
  <div className="text-center py-12">
    <h3 className="mt-2 text-sm font-semibold text-gray-900">No tickets</h3>
    <p className="mt-1 text-sm text-gray-500">Get started by creating a new ticket.</p>
    <div className="mt-6">
      <button
        type="button"
        onClick={() => window.location.href = '/support'}
        className="inline-flex items-center rounded-md bg-blue-600 px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-blue-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-blue-600"
      >
        Create New Ticket
      </button>
    </div>
  </div>
);

const CustomerDashboard = () => {
  const [tickets, setTickets] = useState<Ticket[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const navigate = useNavigate();

  useEffect(() => {
    const fetchTickets = async () => {
      try {
        const { data: { user } } = await supabase.auth.getUser();
        
        if (!user) {
          navigate('/customer-login');
          return;
        }

        const { data, error } = await supabase
          .from('tickets')
          .select('*')
          .eq('customer_email', user.email)
          .order('updated_at', { ascending: false });

        if (error) throw error;
        setTickets(data || []);
      } catch (err) {
        setError(err instanceof Error ? err.message : 'Failed to fetch tickets');
      } finally {
        setLoading(false);
      }
    };

    fetchTickets();
  }, [navigate]);

  return (
    <div className="min-h-screen bg-gray-50">
      <CustomerHeader />
      <div className="py-12">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex justify-between items-center">
            <h1 className="text-3xl font-semibold text-gray-900">Your Tickets</h1>
            <button
              onClick={() => navigate('/support')}
              className="inline-flex items-center rounded-md bg-blue-600 px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-blue-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-blue-600"
            >
              Create New Ticket
            </button>
          </div>

          {loading ? (
            <LoadingSpinner />
          ) : error ? (
            <ErrorMessage message={error} />
          ) : tickets.length === 0 ? (
            <EmptyState />
          ) : (
            <CustomerTicketsTable tickets={tickets} />
          )}
        </div>
      </div>
    </div>
  );
};

export default CustomerDashboard;
