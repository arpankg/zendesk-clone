import { CustomerMessageList } from './CustomerMessageList';
import { CustomerMessageInput } from './CustomerMessageInput';
import type { Database } from '../../../../config/types';

type Ticket = Database['public']['Tables']['tickets']['Row'];
type Customer = Database['public']['Tables']['customers']['Row'];
type MessageEvent = Ticket['ticket_history']['events'][0] & { content: string };

interface CustomerMessageSectionProps {
  messages: MessageEvent[];
  ticket: Ticket;
  customer: Customer | null;
  onSendMessage: (content: string) => Promise<void>;
}

export function CustomerMessageSection({ 
  messages,
  ticket,
  customer,
  onSendMessage
}: CustomerMessageSectionProps) {
  return (
    <div className="flex flex-col flex-1">
      <div className="flex-1 min-h-0">
        <CustomerMessageList 
          messages={messages}
          ticket={ticket}
          customer={customer}
        />
      </div>
      <CustomerMessageInput onSendMessage={onSendMessage} />
    </div>
  );
}
