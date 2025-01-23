import { useEffect, useState } from 'react';
import { useParams } from 'react-router-dom';
import { supabase } from '../../config/supabase';
import LoadingSpinner from '../components/common/LoadingSpinner';
import ErrorMessage from '../components/common/ErrorMessage';
import { TicketDetailsPanel } from '../components/ticket/TicketDetailsPanel';
import { TicketListPanel } from '../components/ticket/TicketListPanel';
import { MessageSection } from '../components/ticket/MessageSection';
import type { Database } from '../../config/types';

type Ticket = Database['public']['Tables']['tickets']['Row'];
type Customer = Database['public']['Tables']['customers']['Row'];
type Worker = Database['public']['Tables']['workers']['Row'];

const TicketDetails = () => {
  const { id } = useParams<{ id: string }>();
  const [ticket, setTicket] = useState<Ticket | null>(null);
  const [customer, setCustomer] = useState<Customer | null>(null);
  const [worker, setWorker] = useState<Worker | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchData = async () => {
      try {
        // Get current authenticated user
        const { data: { user } } = await supabase.auth.getUser();
        if (!user) throw new Error('Not authenticated');

        // Get worker data
        const { data: workerData, error: workerError } = await supabase
          .from('workers')
          .select('*')
          .eq('id', user.id)
          .single();

        if (workerError) {
          throw workerError;
        }
        
        setWorker(workerData);

        // Fetch ticket data
        const { data: ticketData, error: ticketError } = await supabase
          .from('tickets')
          .select('*')
          .eq('id', id)
          .single();

        if (ticketError) {
          throw ticketError;
        }
        
        setTicket(ticketData);

        // Fetch customer data
        const { data: customerData, error: customerError } = await supabase
          .from('customers')
          .select('*')
          .eq('email', ticketData.customer_email)
          .single();

        if (customerError) {
          throw customerError;
        }

        setCustomer(customerData);
      } catch (err) {
        const errorMessage = err instanceof Error ? err.message : 'Failed to fetch data';
        setError(errorMessage);
      } finally {
        setLoading(false);
      }
    };

    if (id) {
      fetchData();
    }
  }, [id]);

  const handleSendMessage = async (content: string) => {
    if (!ticket || !worker) return;

    try {
      const now = new Date().toISOString();
      const updates: Partial<Ticket> = {
        updated_at: now,
        ticket_history: {
          events: [
            ...(ticket.ticket_history?.events || []),
            {
              id: crypto.randomUUID(),
              type: 'message',
              content,
              created_at: now,
              created_by_uuid: worker.id,
              created_by_first_name: worker.first_name,
              created_by_last_name: worker.last_name
            }
          ]
        }
      };

      const isAssigned = ticket.assigned_to?.some(agent => agent.id === worker.id) ?? false;
      
      if (!isAssigned) {
        // Add worker to assigned_to array
        updates.assigned_to = [
          ...(ticket.assigned_to || []),
          {
            id: worker.id,
            first_name: worker.first_name,
            last_name: worker.last_name,
            assigned_at: now
          }
        ];

        // Add assignment event
        updates.ticket_history.events.push({
          id: crypto.randomUUID(),
          type: 'assignment',
          created_at: now,
          worker_id: worker.id,
          worker_first_name: worker.first_name,
          worker_last_name: worker.last_name
        });
      }

      // Check if status needs to be updated from 'new' to 'open'
      if (ticket.status === 'new') {
        updates.status = 'open';
        
        // Add status-update event
        updates.ticket_history.events.push({
          id: crypto.randomUUID(),
          type: 'status-update',
          created_at: now,
          old_status: 'new',
          new_status: 'open',
          updated_by_uuid: worker.id,
          updated_by_first_name: worker.first_name,
          updated_by_last_name: worker.last_name
        });
      }

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
      throw err;
    }
  };

  if (loading) {
    return (
      <div className="min-h-screen bg-gray-50 flex items-center justify-center">
        <LoadingSpinner />
      </div>
    );
  }

  if (error || !ticket) {
    return (
      <div className="min-h-screen bg-gray-50 flex items-center justify-center">
        <ErrorMessage message={error || 'Ticket not found'} />
      </div>
    );
  }

  return (
    <div className="h-screen min-h-screen max-h-screen overflow-hidden grid grid-cols-[20rem,1fr,24rem] grid-rows-[auto,1fr] bg-white">
      {/* Header */}
      <div className="col-span-3 border-b border-gray-200">
        <div className="max-w-5xl mx-auto px-4 py-4">
          <div className="flex justify-between items-center">
            <div>
              <h1 className="text-2xl font-semibold text-gray-900">{ticket.title}</h1>
              <p className="text-sm text-gray-500 mt-1">Via {ticket.source_channel}</p>
            </div>
            <div className="flex items-center space-x-4">
              <button 
                className="p-2 text-gray-400 hover:text-gray-600"
                onClick={() => {}}
              >
                <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M3 4a1 1 0 011-1h16a1 1 0 011 1v2.586a1 1 0 01-.293.707l-6.414 6.414a1 1 0 00-.293.707V17l-4 4v-6.586a1 1 0 00-.293-.707L3.293 7.293A1 1 0 013 6.586V4z" />
                </svg>
              </button>
              <button 
                className="p-2 text-gray-400 hover:text-gray-600"
                onClick={() => {}}
              >
                <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 5v.01M12 12v.01M12 19v.01M12 6a1 1 0 110-2 1 1 0 010 2zm0 7a1 1 0 110-2 1 1 0 010 2zm0 7a1 1 0 110-2 1 1 0 010 2z" />
                </svg>
              </button>
            </div>
          </div>
        </div>
      </div>

      {/* Ticket List Panel */}
      <TicketListPanel />

      {/* Messages Section */}
      <MessageSection
        ticket={ticket}
        customer={customer}
        worker={worker}
        onSendMessage={handleSendMessage}
      />

      {/* Ticket Details Panel */}
      {customer && (
        <TicketDetailsPanel
          ticket={ticket}
          customer={customer}
        />
      )}
    </div>
  );
};

export default TicketDetails;
