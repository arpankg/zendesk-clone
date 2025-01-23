import { MessageList } from './MessageList';
import { MessageInput } from './MessageInput';
import type { Database } from '../../../../config/types';
import { useState, useEffect, useRef } from 'react';
import { supabase } from '../../../../config/supabase';

type Ticket = Database['public']['Tables']['tickets']['Row'];
type Customer = Database['public']['Tables']['customers']['Row'];
type Worker = Database['public']['Tables']['workers']['Row'];
type MessageEvent = Ticket['ticket_history']['events'][0] & { content: string };
type TicketStatus = 'new' | 'open' | 'pending' | 'closed';
type TicketPriority = 'low' | 'medium' | 'high';

interface MessageSectionProps {
  ticket: Ticket;
  customer: Customer | null;
  worker: Worker | null;
  onSendMessage: (content: string) => Promise<void>;
}

export function MessageSection({ ticket, customer, worker, onSendMessage }: MessageSectionProps) {
  const [activeDropdown, setActiveDropdown] = useState<'status' | 'priority' | null>(null);
  const [updating, setUpdating] = useState(false);
  const statusButtonRef = useRef<HTMLDivElement>(null);
  const priorityButtonRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    const handleClickOutside = (event: MouseEvent) => {
      if (!statusButtonRef.current?.contains(event.target as Node) && 
          !priorityButtonRef.current?.contains(event.target as Node)) {
        setActiveDropdown(null);
      }
    };

    document.addEventListener('click', handleClickOutside);
    return () => document.removeEventListener('click', handleClickOutside);
  }, []);

  const statusOptions: TicketStatus[] = ['new', 'open', 'pending', 'closed'];
  const priorityOptions: TicketPriority[] = ['low', 'medium', 'high'];

  const updateTicket = async (field: 'status' | 'priority', value: string) => {
    if (updating) return;
    
    setUpdating(true);
    try {
      const { error } = await supabase
        .from('tickets')
        .update({ [field]: value })
        .eq('id', ticket.id);

      if (error) throw error;

      // Add to ticket history
      const historyEvent = {
        id: crypto.randomUUID(),
        type: 'field_update',
        created_at: new Date().toISOString(),
        created_by_uuid: worker?.id || '',
        created_by_first_name: worker?.first_name || '',
        created_by_last_name: worker?.last_name || '',
        visibility: 'public',
        field: field,
        old_value: ticket[field],
        new_value: value
      };

      await supabase
        .from('tickets')
        .update({
          ticket_history: {
            events: [...(ticket.ticket_history?.events || []), historyEvent]
          }
        })
        .eq('id', ticket.id);

    } catch (error) {
      console.error('Error updating ticket:', error);
    } finally {
      setUpdating(false);
      setActiveDropdown(null);
    }
  };

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
    <div className="h-full overflow-hidden grid grid-rows-[auto,1fr,auto]">
      <div className="px-4 py-3 border-b bg-white space-y-2">
        <h1 className="text-lg font-semibold text-gray-900">
          {ticket.title}
          {customer && (
            <span className="text-gray-500 font-normal"> • {customer.first_name} {customer.last_name}</span>
          )}
        </h1>
        <div className="flex gap-2 items-center">
          <div className="relative" ref={statusButtonRef}>
            <button
              onClick={() => setActiveDropdown(activeDropdown === 'status' ? null : 'status')}
              disabled={updating}
              className={`px-2 py-0.5 text-xs font-medium rounded-full ${
                {
                  'new': 'bg-blue-100 text-blue-700',
                  'open': 'bg-green-100 text-green-700',
                  'pending': 'bg-yellow-100 text-yellow-700',
                  'closed': 'bg-gray-100 text-gray-700'
                }[ticket.status]
              } hover:opacity-80 transition-opacity`}
            >
              {ticket.status.charAt(0).toUpperCase() + ticket.status.slice(1)}
            </button>
            
            {activeDropdown === 'status' && (
              <div className="absolute top-full left-0 mt-1 w-32 bg-white rounded-md shadow-lg border border-gray-200 py-1 z-10">
                {statusOptions.map((status) => (
                  <button
                    key={status}
                    onClick={() => updateTicket('status', status)}
                    className={`w-full px-3 py-1 text-left text-sm ${
                      {
                        'new': 'text-blue-700 hover:bg-blue-50',
                        'open': 'text-green-700 hover:bg-green-50',
                        'pending': 'text-yellow-700 hover:bg-yellow-50',
                        'closed': 'text-gray-700 hover:bg-gray-50'
                      }[status]
                    }`}
                  >
                    {status.charAt(0).toUpperCase() + status.slice(1)}
                  </button>
                ))}
              </div>
            )}
          </div>

          <div className="relative" ref={priorityButtonRef}>
            <button
              onClick={() => setActiveDropdown(activeDropdown === 'priority' ? null : 'priority')}
              disabled={updating}
              className={`px-2 py-0.5 text-xs font-medium rounded-full ${
                {
                  'high': 'bg-red-100 text-red-700',
                  'medium': 'bg-yellow-100 text-yellow-700',
                  'low': 'bg-green-100 text-green-700'
                }[ticket.priority]
              } hover:opacity-80 transition-opacity`}
            >
              {ticket.priority.charAt(0).toUpperCase() + ticket.priority.slice(1)} Priority
            </button>
            
            {activeDropdown === 'priority' && (
              <div className="absolute top-full left-0 mt-1 w-32 bg-white rounded-md shadow-lg border border-gray-200 py-1 z-10">
                {priorityOptions.map((priority) => (
                  <button
                    key={priority}
                    onClick={() => updateTicket('priority', priority)}
                    className={`w-full px-3 py-1 text-left text-sm ${
                      {
                        'high': 'text-red-700 hover:bg-red-50',
                        'medium': 'text-yellow-700 hover:bg-yellow-50',
                        'low': 'text-green-700 hover:bg-green-50'
                      }[priority]
                    }`}
                  >
                    {priority.charAt(0).toUpperCase() + priority.slice(1)}
                  </button>
                ))}
              </div>
            )}
          </div>
        </div>
        {customer ? (
          <div className="text-sm text-gray-600 space-y-1">
            <div>
              <span className="font-medium">Email:</span> {customer.email}
            </div>
          </div>
        ) : (
          <div className="text-sm text-gray-500 italic">Customer information not available</div>
        )}
      </div>
      <MessageList 
        messages={messages}
        ticket={ticket}
        customer={customer}
      />
      <MessageInput 
        onSendMessage={onSendMessage}
        disabled={!worker}
      />
    </div>
  );
}
