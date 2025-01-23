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
      day: 'numeric'
    })
  }

  const formatTime = (date: string) => {
    return new Date(date).toLocaleString('en-US', {
      hour: '2-digit',
      minute: '2-digit',
      hour12: true
    })
  }

  const getEventTypeDisplay = (type: string): { label: string; color: string } => {
    switch (type) {
      case 'status_change':
        return { label: 'Status Update', color: 'text-orange-500' }
      case 'priority_change':
        return { label: 'Priority Change', color: 'text-red-500' }
      case 'note_added':
        return { label: 'Message', color: 'text-blue-500' }
      case 'tag_added':
        return { label: 'Tag Added', color: 'text-gray-500' }
      case 'tag_removed':
        return { label: 'Tag Removed', color: 'text-gray-500' }
      default:
        return { label: 'Event', color: 'text-gray-500' }
    }
  }

  const getEventDescription = (event: TicketEvent) => {
    const performedBy = `${event.created_by_first_name} ${event.created_by_last_name}`
    
    switch (event.type) {
      case 'status_change':
        return `changed status from ${event.old_value} to ${event.new_value}`
      case 'priority_change':
        return `changed priority from ${event.old_value} to ${event.new_value}`
      case 'note_added':
        return event.content || ''
      case 'tag_added':
        return `added tag: ${event.new_value}`
      case 'tag_removed':
        return `removed tag: ${event.old_value}`
      default:
        return event.content || `performed ${event.type}`
    }
  }

  const getDotColorForEventType = (type: string): string => {
    switch (type) {
      case 'status_change':
        return 'bg-orange-400'
      case 'priority_change':
        return 'bg-red-400'
      case 'note_added':
        return 'bg-blue-400'
      case 'tag_added':
      case 'tag_removed':
        return 'bg-gray-400'
      default:
        return 'bg-gray-400'
    }
  }

  return (
    <div className="pb-4">
      <div className="flex items-center justify-between mb-6">
        <h3 className="text-sm font-medium text-gray-900">Audit Log</h3>
      </div>

      <div className="relative">
        {/* Timeline vertical line */}
        <div className="absolute left-[5.75rem] top-0 bottom-0 w-px bg-gray-200" />
        
        {/* Events */}
        <div className="space-y-6">
          {events.map((event) => {
            const eventType = getEventTypeDisplay(event.type)
            return (
              <div key={event.id} className="grid grid-cols-[92px,40px,1fr] items-start gap-0">
                {/* Metadata Column */}
                <div className="flex flex-col space-y-1">
                  {/* Date/Time */}
                  <div>
                    <div className="text-sm font-medium text-gray-900">
                      {formatDate(event.created_at)}
                    </div>
                    <div className="text-xs text-gray-500">
                      {formatTime(event.created_at)}
                    </div>
                  </div>
                  
                  {/* Performed By - truncate if too long */}
                  <div className="text-xs text-gray-700 truncate" title={`${event.created_by_first_name} ${event.created_by_last_name}`}>
                    {event.created_by_first_name} {event.created_by_last_name}
                  </div>
                  
                  {/* Event Type */}
                  <div className={`text-xs font-medium ${eventType.color}`}>
                    {eventType.label}
                  </div>
                </div>
                
                {/* Timeline dot */}
                <div className="relative flex justify-center">
                  <div className={`w-2.5 h-2.5 rounded-full ${getDotColorForEventType(event.type)} ring-4 ring-white`} />
                </div>
                
                {/* Event content */}
                <div className="bg-gray-50 rounded-lg p-3 shadow-sm">
                  <div className="text-sm text-gray-900">
                    {getEventDescription(event)}
                  </div>
                  {event.content && event.type !== 'note_added' && (
                    <div className="mt-2 text-sm text-gray-600 border-l-2 border-gray-200 pl-3">
                      {event.content}
                    </div>
                  )}
                </div>
              </div>
            )
          })}
          {events.length === 0 && (
            <div className="text-sm text-gray-500 italic pl-32">No audit log entries found</div>
          )}
        </div>
      </div>
    </div>
  )
}
