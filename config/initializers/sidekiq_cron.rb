Sidekiq::Cron::Job.create(
  name: "Sync Hostaway reservations",
  cron: "0 4 */1 * *", # at 4 am every day
  class: "Hostaway::SyncReservationsWorker"
)
