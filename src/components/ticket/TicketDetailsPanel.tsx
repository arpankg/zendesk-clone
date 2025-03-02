import { type Ticket, type Customer, type Worker } from '@/config/types'
import { CustomerSection } from './CustomerSection'
import { TimeSection } from './TimeSection'
import { PropertiesSection } from './PropertiesSection'
import { NotesSection } from './NotesSection'
import { AuditLogSection } from './AuditLogSection'
import { Tab } from '@headlessui/react'
import { supabase } from '../../../config/supabase'

interface TicketDetailsPanelProps {
  ticket: Ticket
  customer: Customer
  worker: Worker | null
  onTicketUpdate: (ticket: Ticket) => void
}

export function TicketDetailsPanel({ 
  ticket, 
  customer,
  worker,
  onTicketUpdate
}: TicketDetailsPanelProps) {
  const handleRemoveTag = async (tagToRemove: string) => {
    try {
      const newTags = ticket.tags.filter(tag => tag !== tagToRemove)
      
      // Update tags in database
      const { error } = await supabase
        .from('tickets')
        .update({ tags: newTags })
        .eq('id', ticket.id)

      if (error) throw error;

      // Add to ticket history
      const historyEvent = {
        id: crypto.randomUUID(),
        type: 'tag-removed',
        created_at: new Date().toISOString(),
        created_by: worker?.id || '',
        created_by_first_name: worker?.first_name || '',
        created_by_last_name: worker?.last_name || '',
        visibility: 'public',
        old_value: tagToRemove,
        new_value: null
      }

      const updatedHistory = {
        events: [...(ticket.ticket_history?.events || []), historyEvent]
      }

      await supabase
        .from('tickets')
        .update({
          ticket_history: updatedHistory
        })
        .eq('id', ticket.id)

      // Update local state
      onTicketUpdate({
        ...ticket,
        tags: newTags,
        ticket_history: updatedHistory
      })
    } catch (error) {
      console.error('Error removing tag:', error)
    }
  }

  const handleAddTag = async (newTag: string) => {
    try {
      // Update tags in database
      const newTags = [...ticket.tags, newTag]
      const { error } = await supabase
        .from('tickets')
        .update({ tags: newTags })
        .eq('id', ticket.id)

      if (error) throw error;

      // Add to ticket history
      const historyEvent = {
        id: crypto.randomUUID(),
        type: 'tag-added',
        created_at: new Date().toISOString(),
        created_by: worker?.id || '',
        created_by_first_name: worker?.first_name || '',
        created_by_last_name: worker?.last_name || '',
        visibility: 'public',
        new_value: newTag,
        old_value: null
      }

      const updatedHistory = {
        events: [...(ticket.ticket_history?.events || []), historyEvent]
      }

      await supabase
        .from('tickets')
        .update({ ticket_history: updatedHistory })
        .eq('id', ticket.id)

      // Update local state
      onTicketUpdate({
        ...ticket,
        tags: newTags,
        ticket_history: updatedHistory
      })
    } catch (error) {
      console.error('Error adding tag:', error)
    }
  }

  const handleAddNote = async (noteContent: string) => {
    try {
      // Generate a single UUID for the note
      const noteId = crypto.randomUUID()
      
      // Create new note object
      const newNote = {
        id: noteId,
        content: noteContent,
        created_at: new Date().toISOString(),
        created_by: worker?.id || ''
      }
      
      // Update internal_notes in database
      const updatedNotes = {
        notes: [...(ticket.internal_notes?.notes || []), newNote]
      }
      
      const { error } = await supabase
        .from('tickets')
        .update({ internal_notes: updatedNotes })
        .eq('id', ticket.id)

      if (error) throw error;

      // Add to ticket history with content and note_id
      const historyEvent = {
        id: crypto.randomUUID(),
        type: 'note-added',
        content: noteContent,
        note_id: noteId,
        created_at: new Date().toISOString(),
        created_by: worker?.id || '',
        created_by_first_name: worker?.first_name || '',
        created_by_last_name: worker?.last_name || '',
        visibility: 'private'
      }

      const updatedHistory = {
        events: [...(ticket.ticket_history?.events || []), historyEvent]
      }

      await supabase
        .from('tickets')
        .update({ ticket_history: updatedHistory })
        .eq('id', ticket.id)

      // Update local state
      onTicketUpdate({
        ...ticket,
        internal_notes: updatedNotes,
        ticket_history: updatedHistory
      })
    } catch (error) {
      console.error('Error adding note:', error)
    }
  }

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
              sourceChannel={ticket.source_channel}
              tags={ticket.tags || []}
              onRemoveTag={handleRemoveTag}
              onAddTag={handleAddTag}
            />
            <NotesSection 
              notes={ticket.internal_notes?.notes || []}
              onAddNote={handleAddNote}
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
