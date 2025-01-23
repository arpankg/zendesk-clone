import { MessageList } from './MessageList';
import { MessageInput } from './MessageInput';
import type { Database } from '../../../../config/types';

type Ticket = Database['public']['Tables']['tickets']['Row'];
type Customer = Database['public']['Tables']['customers']['Row'];
type Worker = Database['public']['Tables']['workers']['Row'];
type MessageEvent = Ticket['ticket_history']['events'][0] & { content: string };

interface MessageSectionProps {
  ticket: Ticket;
  customer: Customer | null;
  worker: Worker | null;
  onSendMessage: (content: string) => Promise<void>;
}

export function MessageSection({ ticket, customer, worker, onSendMessage }: MessageSectionProps) {
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
    <div className="h-full overflow-hidden grid grid-rows-[1fr,auto]">
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
