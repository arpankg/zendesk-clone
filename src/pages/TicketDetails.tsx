import { useEffect, useState } from 'react';
import { useParams } from 'react-router-dom';
import { supabase } from '../../config/supabase';
import LoadingSpinner from '../components/common/LoadingSpinner';
import ErrorMessage from '../components/common/ErrorMessage';
import { MessageBubble } from '../components/common/MessageBubble';
import { TicketDetailsPanel } from '../components/ticket/TicketDetailsPanel';
import { TicketListPanel } from '../components/ticket/TicketListPanel';
import { formatMessageDate } from '../lib/utils';
import type { Database } from '../../config/types';

type Ticket = Database['public']['Tables']['tickets']['Row'];
type Customer = Database['public']['Tables']['customers']['Row'];
type Worker = Database['public']['Tables']['workers']['Row'];
type MessageEvent = Ticket['ticket_history']['events'][0] & { content: string };

const TicketDetails = () => {
  const { id } = useParams<{ id: string }>();
  const [ticket, setTicket] = useState<Ticket | null>(null);
  const [customer, setCustomer] = useState<Customer | null>(null);
  const [worker, setWorker] = useState<Worker | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [newMessage, setNewMessage] = useState('');
  const [isSending, setIsSending] = useState(false);

  useEffect(() => {
    
    const fetchData = async () => {
      try {
        // Get current authenticated user
        const { data: { user }, error: authError } = await supabase.auth.getUser();
        if (authError) throw authError;
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
    } else {
    }
  }, [id]);

  const handleSendMessage = async () => {
    if (!newMessage.trim() || isSending || !worker) return;

    setIsSending(true);

    try {
      const updates: any = {
        ticket_history: {
          events: [...(ticket.ticket_history?.events || [])]
        },
        updated_at: new Date().toISOString()
      };

      // Check if worker is assigned to ticket
      const isAssigned = ticket.assigned_to?.some(agent => agent.id === worker.id) ?? false;
      
      if (!isAssigned) {
        // Add worker to assigned_to array
        updates.assigned_to = [
          ...(ticket.assigned_to || []),
          {
            id: worker.id,
            first_name: worker.first_name,
            last_name: worker.last_name
          }
        ];

        // Add assignment-added event
        updates.ticket_history.events.push({
          id: crypto.randomUUID(),
          type: 'assignment-added',
          agent_id: worker.id,
          created_at: new Date().toISOString(),
          created_by_uuid: worker.id,
          created_by_first_name: worker.first_name,
          created_by_last_name: worker.last_name,
          visibility: 'public'
        });
      }

      // Check if status needs to be updated from 'new' to 'open'
      if (ticket.status === 'new') {
        updates.status = 'open';
        
        // Add status-update event
        updates.ticket_history.events.push({
          id: crypto.randomUUID(),
          type: 'status-update',
          old_value: 'new',
          new_value: 'open',
          created_at: new Date().toISOString(),
          created_by_uuid: worker.id,
          created_by_first_name: worker.first_name,
          created_by_last_name: worker.last_name,
          visibility: 'public'
        });
      }

      // Add the message event
      const newMessageEvent = {
        id: crypto.randomUUID(),
        type: 'message' as const,
        content: newMessage.trim(),
        created_at: new Date().toISOString(),
        created_by_uuid: worker.id,
        created_by_first_name: worker.first_name,
        created_by_last_name: worker.last_name,
        visibility: 'public' as const,
        attachments: []
      };

      updates.ticket_history.events.push(newMessageEvent);

      // Update the ticket in database
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
      setNewMessage('');
    } catch (err) {
    } finally {
      setIsSending(false);
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

  const messages = (ticket.ticket_history?.events || [])
    .filter((event): event is MessageEvent => {
      const isMessage = event.type === 'message' && typeof event.content === 'string';
      return isMessage;
    })
    .sort((a, b) => {
      const timeA = new Date(a.created_at).getTime();
      const timeB = new Date(b.created_at).getTime();
      return timeA - timeB;
    });

  return (
    <div className="h-screen grid grid-cols-[20rem,1fr,24rem] grid-rows-[auto,1fr] bg-white">
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
      <div className="grid grid-rows-[1fr,auto]">
        {/* Messages List */}
        <div className="overflow-y-auto">
          <div className="max-w-5xl mx-auto px-4 py-6">
            <div className="space-y-6">
              {messages.map((message) => {
                const isCustomer = message.created_by_uuid === ticket.created_by;
                const name = isCustomer && customer
                  ? `${customer.first_name} ${customer.last_name}`
                  : `${message.created_by_first_name} ${message.created_by_last_name}`;
                
                return (
                  <MessageBubble
                    key={message.id}
                    isCustomer={!isCustomer}
                    message={message.content}
                    timestamp={formatMessageDate(message.created_at)}
                    username={name}
                    channel={ticket.source_channel}
                  />
                );
              })}
              {messages.length === 0 && (
                <div className="text-center text-gray-500 py-8">
                  No messages in this ticket yet.
                </div>
              )}
            </div>
          </div>
        </div>

        {/* Message Input */}
        <div className="border-t border-gray-200 bg-white p-4">
          <div className="max-w-5xl mx-auto">
            <div className="flex items-center space-x-4">
              <input
                type="text"
                placeholder="Type your message..."
                className="flex-1 min-w-0 rounded-lg border border-gray-300 px-4 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
                value={newMessage}
                onChange={(e) => {
                  setNewMessage(e.target.value);
                }}
                onKeyDown={(e) => {
                  if (e.key === 'Enter' && !e.shiftKey) {
                    e.preventDefault();
                    handleSendMessage();
                  }
                }}
              />
              <button
                className="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
                onClick={handleSendMessage}
              >
                Send
              </button>
            </div>
          </div>
        </div>
      </div>

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
