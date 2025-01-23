import { type Ticket, type Customer } from '@/config/types'
import { CustomerSection } from './CustomerSection'
import { TimeSection } from './TimeSection'
import { PropertiesSection } from './PropertiesSection'
import { NotesSection } from './NotesSection'
import { AuditLogSection } from './AuditLogSection'
import { Tab } from '@headlessui/react'

interface TicketDetailsPanelProps {
  ticket: Ticket
  customer: Customer
}

export function TicketDetailsPanel({ ticket, customer }: TicketDetailsPanelProps) {
  return (
    <div className="border-l border-gray-200 bg-white overflow-y-auto">
      <Tab.Group>
        <Tab.List className="border-b border-gray-200">
          <Tab className={({ selected }) =>
            `px-4 py-2 text-sm font-medium focus:outline-none ${
              selected
                ? 'text-blue-600 border-b-2 border-blue-600'
                : 'text-gray-500 hover:text-gray-700 hover:border-gray-300'
            }`
          }>
            Details & Notes
          </Tab>
          <Tab className={({ selected }) =>
            `px-4 py-2 text-sm font-medium focus:outline-none ${
              selected
                ? 'text-blue-600 border-b-2 border-blue-600'
                : 'text-gray-500 hover:text-gray-700 hover:border-gray-300'
            }`
          }>
            Audit Log
          </Tab>
        </Tab.List>
        <Tab.Panels>
          <Tab.Panel className="p-4 space-y-6">
            <PropertiesSection 
              status={ticket.status}
              priority={ticket.priority}
              sourceChannel={ticket.source_channel}
              tags={ticket.tags}
            />
            <NotesSection 
              notes={ticket.internal_notes?.notes || []}
            />
          </Tab.Panel>
          <Tab.Panel className="p-4">
            <AuditLogSection 
              events={ticket.ticket_history?.events || []}
            />
          </Tab.Panel>
        </Tab.Panels>
      </Tab.Group>
    </div>
  )
}
