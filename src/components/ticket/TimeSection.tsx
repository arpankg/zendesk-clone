interface TimeSectionProps {
  createdAt: string | null
  updatedAt: string | null
  isExpanded?: boolean
}

export function TimeSection({ createdAt, updatedAt, isExpanded = true }: TimeSectionProps) {
  const formatDate = (date: string | null) => {
    if (!date) return 'Not available'
    return new Date(date).toLocaleString('en-US', {
      month: 'short',
      day: 'numeric',
      year: 'numeric',
      hour: '2-digit',
      minute: '2-digit',
      hour12: true
    })
  }

  return (
    <div className="border-b border-gray-200 pb-4">
      <div className="flex items-center justify-between mb-2">
        <h3 className="text-sm font-medium text-gray-900">Time</h3>
        <button className="p-1 text-gray-400 hover:text-gray-600">
          <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
          </svg>
        </button>
      </div>

      {isExpanded && (
        <div className="space-y-3">
          <div>
            <div className="text-sm text-gray-500">Created</div>
            <div className="mt-1 text-sm text-gray-900">{formatDate(createdAt)}</div>
          </div>

          <div>
            <div className="text-sm text-gray-500">Updated</div>
            <div className="mt-1 text-sm text-gray-900">{formatDate(updatedAt)}</div>
          </div>

          <div>
            <div className="text-sm text-gray-500">Local time</div>
            <div className="mt-1 text-sm text-gray-900">
              {new Date().toLocaleTimeString('en-US', {
                hour: '2-digit',
                minute: '2-digit',
                hour12: true,
                timeZoneName: 'short'
              })}
            </div>
          </div>
        </div>
      )}
    </div>
  )
}
