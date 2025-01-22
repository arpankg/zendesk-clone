interface Note {
  id: string
  content: string
  created_at: string | null
  created_by: string
}

interface NotesSectionProps {
  notes: Note[]
  isExpanded?: boolean
}

export function NotesSection({ notes, isExpanded = true }: NotesSectionProps) {
  const formatDate = (date: string | null) => {
    if (!date) return ''
    return new Date(date).toLocaleString('en-US', {
      month: 'short',
      day: 'numeric',
      hour: '2-digit',
      minute: '2-digit',
      hour12: true
    })
  }

  return (
    <div className="pb-4">
      <div className="flex items-center justify-between mb-2">
        <h3 className="text-sm font-medium text-gray-900">Internal Notes</h3>
        <div className="flex items-center space-x-2">
          <button className="text-sm text-blue-600 hover:text-blue-700">
            Add note
          </button>
          <button className="p-1 text-gray-400 hover:text-gray-600">
            <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
            </svg>
          </button>
        </div>
      </div>

      {isExpanded && (
        <div className="space-y-4">
          {notes.map((note) => (
            <div key={note.id} className="bg-gray-50 rounded-lg p-3">
              <div className="text-sm text-gray-900">{note.content}</div>
              <div className="mt-2 text-xs text-gray-500">
                {formatDate(note.created_at)}
              </div>
            </div>
          ))}
          {notes.length === 0 && (
            <div className="text-sm text-gray-500 text-center py-4">
              No internal notes yet
            </div>
          )}
        </div>
      )}
    </div>
  )
}
