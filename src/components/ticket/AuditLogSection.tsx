interface TicketEvent {
  id: string
  type: string
  content?: string
  created_at: string
  created_by_uuid: string
  created_by_first_name: string
  created_by_last_name: string
  visibility: 'public' | 'private'
  attachments?: string[]
  old_value?: string
  new_value?: string
  [key: string]: any
}

interface AuditLogSectionProps {
  events: TicketEvent[]
}

export function AuditLogSection({ events }: AuditLogSectionProps) {
  const formatDate = (date: string) => {
    return new Date(date).toLocaleString('en-US', {
      month: 'short',
      day: 'numeric',
      hour: '2-digit',
      minute: '2-digit',
      hour12: true
    })
  }

  const getEventDescription = (event: TicketEvent) => {
    const actor = `${event.created_by_first_name} ${event.created_by_last_name}`
    
    switch (event.type) {
      case 'status_change':
        return `${actor} changed status from ${event.old_value} to ${event.new_value}`
      case 'priority_change':
        return `${actor} changed priority from ${event.old_value} to ${event.new_value}`
      case 'note_added':
        return `${actor} added a ${event.visibility} note`
      case 'tag_added':
        return `${actor} added tag: ${event.new_value}`
      case 'tag_removed':
        return `${actor} removed tag: ${event.old_value}`
      default:
        return event.content || `${actor} performed ${event.type}`
    }
  }

  return (
    <div className="pb-4">
      <div className="flex items-center justify-between mb-2">
        <h3 className="text-sm font-medium text-gray-900">Audit Log</h3>
      </div>

      <div className="space-y-4">
        {events.map((event) => (
          <div key={event.id} className="bg-gray-50 rounded-lg p-3">
            <div className="text-sm text-gray-900">
              {getEventDescription(event)}
            </div>
            <div className="mt-2 text-xs text-gray-500">
              {formatDate(event.created_at)}
            </div>
          </div>
        ))}
        {events.length === 0 && (
          <div className="text-sm text-gray-500 italic">No audit log entries found</div>
        )}
      </div>
    </div>
  )
}
