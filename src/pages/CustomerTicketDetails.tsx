import React, { useEffect, useState } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import { CustomerHeader } from '../components/customer/CustomerHeader';
import { CustomerMessageSection } from '../components/ticket/MessageSection/CustomerMessageSection';
import { formatRelativeDate } from '../utils/dateUtils';
import { supabase } from '../../config/supabase';
import type { Database } from '../../config/types';

type Ticket = Database['public']['Tables']['tickets']['Row'];
type Customer = Database['public']['Tables']['customers']['Row'];

const CustomerTicketDetails: React.FC = () => {
  const navigate = useNavigate();
  const { id } = useParams();
  const [ticket, setTicket] = useState<Ticket | null>(null);
  const [customer, setCustomer] = useState<Customer | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchTicketData = async () => {
      try {
        // Get current user
        const { data: { user } } = await supabase.auth.getUser();
        
        if (!user) {
          navigate('/customer-login');
          return;
        }

        // Fetch ticket data
        const { data: ticketData, error: ticketError } = await supabase
          .from('tickets')
          .select('*')
          .eq('id', id)
          .eq('customer_email', user.email)
          .single();

        if (ticketError) throw ticketError;
        if (!ticketData) throw new Error('Ticket not found');

        setTicket(ticketData);

        // Fetch customer data
        const { data: customerData, error: customerError } = await supabase
          .from('customers')
          .select('*')
          .eq('email', user.email)
          .single();

        if (customerError) throw customerError;
        setCustomer(customerData);

      } catch (err) {
        setError(err instanceof Error ? err.message : 'An error occurred');
      } finally {
        setLoading(false);
      }
    };

    fetchTicketData();
  }, [id, navigate]);

  const handleCloseTicket = async () => {
    if (!ticket) return;

    try {
      const { error } = await supabase
        .from('tickets')
        .update({ status: 'closed' })
        .eq('id', ticket.id);

      if (error) throw error;
      
      // Update local state
      setTicket(prev => prev ? { ...prev, status: 'closed' } : null);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to close ticket');
    }
  };

  const handleSendMessage = async (content: string) => {
    if (!ticket || !customer) return;

    try {
      const now = new Date().toISOString();
      const updates = {
        updated_at: now,
        ticket_history: {
          events: [
            ...(ticket.ticket_history?.events || []),
            {
              id: crypto.randomUUID(),
              type: 'message',
              content,
              created_at: now,
              created_by_uuid: customer.id,
              created_by_first_name: customer.first_name,
              created_by_last_name: customer.last_name,
              visibility: "public"
            }
          ]
        }
      };

      const { error: updateError } = await supabase
        .from('tickets')
        .update(updates)
        .eq('id', id);

      if (updateError) {
        throw updateError;
      }

      setTicket(prev => prev ? {
        ...prev,
        ...updates
      } : null);
    } catch (err) {
      console.error('Error sending message:', err);
      throw err;
    }
  };

  if (loading) {
    return (
      <div className="h-screen flex flex-col bg-gray-100">
        <CustomerHeader />
        <div className="flex-1 overflow-hidden py-6">
          <div className="max-w-2xl mx-auto px-4 sm:px-6 lg:px-8">
            <div className="text-center">Loading ticket details...</div>
          </div>
        </div>
      </div>
    );
  }

  if (error || !ticket) {
    return (
      <div className="h-screen flex flex-col bg-gray-100">
        <CustomerHeader />
        <div className="flex-1 overflow-hidden py-6">
          <div className="max-w-2xl mx-auto px-4 sm:px-6 lg:px-8">
            <div className="text-center text-red-600">{error || 'Ticket not found'}</div>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="h-screen flex flex-col">
      <CustomerHeader />
      <main className="flex-1 overflow-hidden pt-2">
        <div className="max-w-7xl mx-auto px-4 w-full h-full">
          {/* Back button */}
          <button
            onClick={() => navigate('/customer-dashboard')}
            className="flex items-center text-base text-gray-600 hover:text-gray-900 py-2 px-3 hover:bg-gray-50 rounded-md transition-colors"
          >
            <svg className="mr-2 h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
              <path fillRule="evenodd" d="M7.707 14.707a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 1.414L5.414 9H17a1 1 0 110 2H5.414l2.293 2.293a1 1 0 010 1.414z" clipRule="evenodd" />
            </svg>
            Back to Dashboard
          </button>

          {/* Header with title and close button */}
          <div className="mt-4 bg-white shadow rounded-lg px-6 py-4">
            <div className="flex items-center justify-between">
              <h1 className="text-2xl font-semibold text-gray-900">{ticket.title}</h1>
              {ticket.status !== 'closed' && (
                <button
                  onClick={handleCloseTicket}
                  className="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-red-600 hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500"
                >
                  Close Ticket
                </button>
              )}
            </div>
          </div>

          {/* Grid layout */}
          <div className="mt-6 grid grid-cols-[minmax(auto,800px),320px] gap-6 h-[calc(100%-8rem)]">
            {/* Message section - Left column */}
            <div className="min-w-0"> {/* min-w-0 prevents grid blowout */}
              <div className="bg-white shadow rounded-lg h-full flex flex-col overflow-hidden">
                <CustomerMessageSection 
                  messages={ticket.ticket_history.events} 
                  ticket={ticket}
                  customer={customer}
                  onSendMessage={handleSendMessage}
                />
              </div>
            </div>

            {/* Ticket info - Right column */}
            <div className="min-w-0"> {/* min-w-0 prevents grid blowout */}
              <div className="bg-gray-50 border rounded-lg p-4 sticky top-4">
                <div className="space-y-4">
                  <div>
                    <dt className="text-sm font-medium text-gray-500">Status</dt>
                    <dd className="mt-1">
                      <span className={`inline-flex rounded-full px-2 text-xs font-semibold leading-5 ${
                        ticket.status === 'new' ? 'bg-blue-100 text-blue-800' :
                        ticket.status === 'open' ? 'bg-yellow-100 text-yellow-800' :
                        ticket.status === 'pending' ? 'bg-purple-100 text-purple-800' :
                        'bg-green-100 text-green-800'
                      }`}>
                        {ticket.status}
                      </span>
                    </dd>
                  </div>
                  <div>
                    <dt className="text-sm font-medium text-gray-500">Priority</dt>
                    <dd className="mt-1 text-sm text-gray-900">{ticket.priority}</dd>
                  </div>
                  <div>
                    <dt className="text-sm font-medium text-gray-500">Created</dt>
                    <dd className="mt-1 text-sm text-gray-900">{formatRelativeDate(ticket.created_at)}</dd>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </main>
    </div>
  );
};

export default CustomerTicketDetails;
