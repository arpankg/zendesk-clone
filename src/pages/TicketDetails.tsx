import { useEffect, useState } from 'react';
import { useParams } from 'react-router-dom';
import { supabase } from '../../config/supabase';
import LoadingSpinner from '../components/common/LoadingSpinner';
import ErrorMessage from '../components/common/ErrorMessage';
import { MessageBubble } from '../components/common/MessageBubble';
import type { Database } from '../../config/types';

// Add logger
const logger = {
  component: (message: string, data?: any) => {
    console.log(`🎯 [TicketDetails] ${message}${data ? '\n' + JSON.stringify(data, null, 2) : ''}`);
  },
  data: (message: string, data?: any) => {
    console.log(`📦 [Data] ${message}${data ? '\n' + JSON.stringify(data, null, 2) : ''}`);
  },
  error: (message: string, error?: any) => {
    console.error(`❌ [Error] ${message}${error ? '\n' + JSON.stringify(error, null, 2) : ''}`);
  },
  event: (message: string, data?: any) => {
    console.log(`🎭 [Event] ${message}${data ? '\n' + JSON.stringify(data, null, 2) : ''}`);
  },
  render: (message: string, data?: any) => {
    console.log(`🎨 [Render] ${message}${data ? '\n' + JSON.stringify(data, null, 2) : ''}`);
  }
};

type Ticket = Database['public']['Tables']['tickets']['Row'];
type Customer = Database['public']['Tables']['customers']['Row'];
type Worker = Database['public']['Tables']['workers']['Row'];
type MessageEvent = Ticket['ticket_history']['events'][0] & { content: string };

const formatMessageDate = (date: string) => {
  logger.event(`Formatting date: ${date}`);
  const messageDate = new Date(date);
  const today = new Date();
  const yesterday = new Date(today);
  yesterday.setDate(yesterday.getDate() - 1);
  
  const days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
  const time = messageDate.toLocaleTimeString('en-US', { 
    hour: '2-digit', 
    minute: '2-digit', 
    hour12: false 
  });

  let formattedDate: string;
  if (messageDate.toDateString() === today.toDateString()) {
    formattedDate = time;
  } else if (messageDate.toDateString() === yesterday.toDateString()) {
    formattedDate = `Yesterday ${time}`;
  } else {
    formattedDate = `${days[messageDate.getDay()]} ${time}`;
  }
  
  logger.event(`Formatted date result: ${formattedDate}`);
  return formattedDate;
};



const TicketDetails = () => {
  logger.component('Component mounted');
  const { id } = useParams<{ id: string }>();
  const [ticket, setTicket] = useState<Ticket | null>(null);
  const [customer, setCustomer] = useState<Customer | null>(null);
  const [worker, setWorker] = useState<Worker | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [messageInput, setMessageInput] = useState('');
  const [isSending, setIsSending] = useState(false);

  useEffect(() => {
    logger.component(`Effect triggered with ticket ID: ${id}`);
    
    const fetchData = async () => {
      try {
        // Get current authenticated user
        const { data: { user }, error: authError } = await supabase.auth.getUser();
        if (authError) throw authError;
        if (!user) throw new Error('Not authenticated');

        // Get worker data
        logger.data('Fetching worker data...');
        const { data: workerData, error: workerError } = await supabase
          .from('workers')
          .select('*')
          .eq('id', user.id)
          .single();

        if (workerError) {
          logger.error('Failed to fetch worker', workerError);
          throw workerError;
        }
        
        logger.data('Worker data fetched successfully', workerData);
        setWorker(workerData);

        // Fetch ticket data
        logger.data('Fetching ticket data...');
        const { data: ticketData, error: ticketError } = await supabase
          .from('tickets')
          .select('*')
          .eq('id', id)
          .single();

        if (ticketError) {
          logger.error('Failed to fetch ticket', ticketError);
          throw ticketError;
        }
        
        logger.data('Ticket data fetched successfully', ticketData);
        setTicket(ticketData);

        // Fetch customer data
        logger.data('Fetching customer data...');
        const { data: customerData, error: customerError } = await supabase
          .from('customers')
          .select('*')
          .eq('email', ticketData.customer_email)
          .single();

        if (customerError) {
          logger.error('Failed to fetch customer', customerError);
          throw customerError;
        }

        logger.data('Customer data fetched successfully', customerData);
        setCustomer(customerData);
      } catch (err) {
        const errorMessage = err instanceof Error ? err.message : 'Failed to fetch data';
        logger.error(errorMessage, err);
        setError(errorMessage);
      } finally {
        logger.data('Fetch operations completed');
        setLoading(false);
      }
    };

    if (id) {
      fetchData();
    } else {
      logger.error('No ticket ID provided');
    }
  }, [id]);

  if (loading) {
    logger.render('Rendering loading state');
    return (
      <div className="min-h-screen bg-gray-50 flex items-center justify-center">
        <LoadingSpinner />
      </div>
    );
  }

  if (error || !ticket) {
    logger.render('Rendering error state', { error });
    return (
      <div className="min-h-screen bg-gray-50 flex items-center justify-center">
        <ErrorMessage message={error || 'Ticket not found'} />
      </div>
    );
  }

  const messages = (ticket.ticket_history?.events || [])
    .filter((event): event is MessageEvent => {
      const isMessage = event.type === 'message' && typeof event.content === 'string';
      logger.data(`Filtering message event: ${event.id}, isValid: ${isMessage}`);
      return isMessage;
    })
    .sort((a, b) => {
      const timeA = new Date(a.created_at).getTime();
      const timeB = new Date(b.created_at).getTime();
      logger.data(`Sorting messages: ${new Date(timeA).toISOString()} vs ${new Date(timeB).toISOString()}`);
      return timeA - timeB;
    });

  logger.render('Rendering ticket details', {
    ticketId: ticket.id,
    messageCount: messages.length,
    status: ticket.status,
    priority: ticket.priority
  });

  return (
    <div className="min-h-screen bg-white flex flex-col">
      {/* Header */}
      <div className="border-b border-gray-200">
        <div className="max-w-5xl mx-auto px-4 py-4">
          <div className="flex justify-between items-center">
            <div>
              <h1 className="text-2xl font-semibold text-gray-900">{ticket.title}</h1>
              <p className="text-sm text-gray-500 mt-1">Via {ticket.source_channel}</p>
            </div>
            <div className="flex items-center space-x-4">
              <button 
                className="p-2 text-gray-400 hover:text-gray-600"
                onClick={() => logger.event('Filter button clicked')}
              >
                <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M3 4a1 1 0 011-1h16a1 1 0 011 1v2.586a1 1 0 01-.293.707l-6.414 6.414a1 1 0 00-.293.707V17l-4 4v-6.586a1 1 0 00-.293-.707L3.293 7.293A1 1 0 013 6.586V4z" />
                </svg>
              </button>
              <button 
                className="p-2 text-gray-400 hover:text-gray-600"
                onClick={() => logger.event('Menu button clicked')}
              >
                <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 5v.01M12 12v.01M12 19v.01M12 6a1 1 0 110-2 1 1 0 010 2zm0 7a1 1 0 110-2 1 1 0 010 2zm0 7a1 1 0 110-2 1 1 0 010 2z" />
                </svg>
              </button>
            </div>
          </div>
        </div>
      </div>

      {/* Messages */}
      <div className="flex-1 overflow-y-auto">
        <div className="max-w-5xl mx-auto px-4 py-6">
          <div className="space-y-6">
            {messages.map((message) => {
              const isCustomer = message.created_by_uuid === ticket.created_by;
              const name = isCustomer && customer
                ? `${customer.first_name} ${customer.last_name}`
                : `${message.created_by_first_name} ${message.created_by_last_name}`;
              
              logger.data('Message sender debug info:', {
                messageId: message.id,
                created_by_uuid: message.created_by_uuid,
                customer_email: ticket.customer_email,
                isCustomer: isCustomer,
                name: name,
                first_name: isCustomer ? customer?.first_name : message.created_by_first_name,
                last_name: isCustomer ? customer?.last_name : message.created_by_last_name
              });
              
              logger.render(`Rendering message`, {
                messageId: message.id,
                isCustomer,
                name,
                timestamp: message.created_at
              });
              
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
      <div className="border-t border-gray-200 bg-white">
        <div className="max-w-5xl mx-auto px-4 py-4">
          <form onSubmit={async (e) => {
            e.preventDefault();
            if (!messageInput.trim() || isSending || !worker) return;

            logger.event('Sending message', { content: messageInput });
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
                logger.event('Adding worker to ticket assignments');
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
                logger.event('Updating ticket status from new to open');
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
              const newMessage = {
                id: crypto.randomUUID(),
                type: 'message' as const,
                content: messageInput.trim(),
                created_at: new Date().toISOString(),
                created_by_uuid: worker.id,
                created_by_first_name: worker.first_name,
                created_by_last_name: worker.last_name,
                visibility: 'public' as const,
                attachments: []
              };

              updates.ticket_history.events.push(newMessage);

              // Update the ticket in database
              const { error: updateError } = await supabase
                .from('tickets')
                .update(updates)
                .eq('id', id);

              if (updateError) {
                logger.error('Failed to update ticket', updateError);
                throw updateError;
              }

              logger.data('Ticket updated successfully');
              setTicket(prev => prev ? {
                ...prev,
                ...updates
              } : null);
              setMessageInput('');
            } catch (err) {
              logger.error('Error sending message', err);
            } finally {
              setIsSending(false);
            }
          }} className="flex gap-2">
            <input
              type="text"
              value={messageInput}
              onChange={(e) => setMessageInput(e.target.value)}
              onKeyDown={(e) => {
                if (e.key === 'Enter' && !e.shiftKey) {
                  e.preventDefault();
                  e.currentTarget.form?.requestSubmit();
                }
              }}
              placeholder="Type your message..."
              className="flex-1 rounded-lg border border-gray-300 px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500"
              disabled={isSending}
            />
            <button
              type="submit"
              disabled={!messageInput.trim() || isSending}
              className="rounded-lg bg-blue-500 px-4 py-2 text-white hover:bg-blue-600 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 disabled:opacity-50 disabled:cursor-not-allowed"
            >
              {isSending ? 'Sending...' : 'Send'}
            </button>
          </form>
        </div>
      </div>
    </div>
  );
};

export default TicketDetails;
