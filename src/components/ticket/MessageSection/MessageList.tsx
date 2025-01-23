import { MessageBubble } from '../../common/MessageBubble';
import { formatMessageDate } from '../../../lib/utils';
import type { Database } from '../../../../config/types';

type Ticket = Database['public']['Tables']['tickets']['Row'];
type Customer = Database['public']['Tables']['customers']['Row'];
type MessageEvent = Ticket['ticket_history']['events'][0] & { content: string };

interface MessageListProps {
  messages: MessageEvent[];
  ticket: Ticket;
  customer: Customer | null;
}

export function MessageList({ messages, ticket, customer }: MessageListProps) {
  return (
    <div className="h-full overflow-y-auto">
      <div className="max-w-5xl mx-auto p-4">
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
  );
}
