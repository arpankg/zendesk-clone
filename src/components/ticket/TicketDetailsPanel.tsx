import { type Ticket, type Customer } from '@/config/types'
import { CustomerSection } from './CustomerSection'
import { TimeSection } from './TimeSection'
import { PropertiesSection } from './PropertiesSection'
import { NotesSection } from './NotesSection'

interface TicketDetailsPanelProps {
  ticket: Ticket
  customer: Customer
}

export function TicketDetailsPanel({ ticket, customer }: TicketDetailsPanelProps) {
  return (
    <div className="border-l border-gray-200 bg-white overflow-y-auto">
      <div className="p-4 space-y-6">
        <CustomerSection customer={customer} />
        <TimeSection 
          createdAt={ticket.created_at}
          updatedAt={ticket.updated_at}
        />
        <PropertiesSection 
          status={ticket.status}
          priority={ticket.priority}
          sourceChannel={ticket.source_channel}
          tags={ticket.tags}
        />
        <NotesSection 
          notes={ticket.internal_notes?.notes || []}
        />
      </div>
    </div>
  )
}
