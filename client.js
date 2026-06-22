document.addEventListener('DOMContentLoaded', () => {
    const sourceSelect = document.getElementById('source');
    const destinationSelect = document.getElementById('destination');
    const searchForm = document.getElementById('search-form');
    const resultsSection = document.getElementById('client-results-section');
    const schedulesContainer = document.getElementById('schedules-container');
    const loading = document.getElementById('loading');
    
    const modal = document.getElementById('booking-modal');
    const closeBtn = document.querySelector('.close-btn');
    const bookingForm = document.getElementById('booking-form');
    const bookScheduleId = document.getElementById('book-schedule-id');
    const bookingDetailsText = document.getElementById('booking-details-text');

    const API_BASE = '/api';

    // Fetch cities on load
    fetch(`${API_BASE}/cities`)
        .then(res => res.json())
        .then(data => {
            const srcList = document.querySelector('#dropdown-source .dropdown-list');
            const destList = document.querySelector('#dropdown-destination .dropdown-list');

            data.forEach(row => {
                const li1 = document.createElement('li');
                li1.textContent = row.city;
                li1.dataset.value = row.city;
                srcList.appendChild(li1);

                const li2 = document.createElement('li');
                li2.textContent = row.city;
                li2.dataset.value = row.city;
                destList.appendChild(li2);
            });

            setupDropdown('dropdown-source', 'source');
            setupDropdown('dropdown-destination', 'destination');
        })
        .catch(err => console.error("Error fetching cities:", err));

    function setupDropdown(dropdownId, inputId) {
        const dropdown = document.getElementById(dropdownId);
        const header = dropdown.querySelector('.dropdown-header');
        const list = dropdown.querySelector('.dropdown-list');
        const input = document.getElementById(inputId);
        const selectedValue = dropdown.querySelector('.selected-value');

        header.addEventListener('click', (e) => {
            e.stopPropagation();
            // Close all others
            document.querySelectorAll('.dropdown-list').forEach(l => {
                if(l !== list) l.classList.add('hidden');
            });
            list.classList.toggle('hidden');
        });

        list.addEventListener('click', (e) => {
            if(e.target.tagName === 'LI') {
                selectedValue.textContent = e.target.textContent;
                input.value = e.target.dataset.value;
                list.classList.add('hidden');
            }
        });
    }

    document.addEventListener('click', () => {
        document.querySelectorAll('.dropdown-list').forEach(l => l.classList.add('hidden'));
    });
    // Handle search
    searchForm.addEventListener('submit', (e) => {
        e.preventDefault();
        const source = document.getElementById('source').value;
        const dest = document.getElementById('destination').value;
        
        if(!source || !dest) {
            alert("Please select both Leaving From and Going To cities.");
            return;
        }
        
        if(source === dest) {
            alert("Source and destination cannot be the same.");
            return;
        }

        resultsSection.style.display = 'block';
        schedulesContainer.innerHTML = '';
        loading.classList.remove('hidden');

        fetch(`${API_BASE}/search?source=${encodeURIComponent(source)}&destination=${encodeURIComponent(dest)}`)
            .then(res => res.json())
            .then(data => {
                loading.classList.add('hidden');
                if(data.length === 0) {
                    schedulesContainer.innerHTML = '<p>No buses found for this route.</p>';
                    return;
                }

                data.forEach(schedule => {
                    const card = document.createElement('div');
                    card.className = 'schedule-card glass-panel';
                    
                    const depDate = new Date(schedule.departure_time).toLocaleString();
                    const arrDate = new Date(schedule.arrival_time).toLocaleString();

                    card.innerHTML = `
                        <h4>${schedule.bus_type}</h4>
                        <div class="schedule-details">
                            <p><strong>Departure:</strong> ${depDate}</p>
                            <p><strong>Arrival:</strong> ${arrDate}</p>
                            <p><strong>Fare:</strong> ₹${schedule.fare}</p>
                        </div>
                        <button class="btn secondary book-btn" data-id="${schedule.schedule_id}" data-desc="${schedule.source} to ${schedule.destination}" data-fare="${schedule.fare}">Book Now</button>
                    `;
                    schedulesContainer.appendChild(card);
                });

                // --- Multi-Step Booking Flow Elements ---
                const bookingFlowSection = document.getElementById('booking-flow-section');
                const step1Tickets = document.getElementById('step-1-tickets');
                const step2Payment = document.getElementById('step-2-payment');
                const step3Success = document.getElementById('step-3-success');
                
                const bookingRouteText = document.getElementById('booking-route-text');
                const ticketCountSelect = document.getElementById('ticket-count');
                const dynamicPassengersContainer = document.getElementById('dynamic-passengers-container');
                const summaryBaseFare = document.getElementById('summary-base-fare');
                const summaryTicketsCount = document.getElementById('summary-tickets-count');
                const summaryTotalFare = document.getElementById('summary-total-fare');
                
                let currentScheduleId = null;
                let currentBaseFare = 0;
                let selectedTickets = 1;

                function renderPassengerRows(count) {
                    dynamicPassengersContainer.innerHTML = '';
                    for(let i = 1; i <= count; i++) {
                        dynamicPassengersContainer.innerHTML += `
                            <div class="passenger-entry mt-10" style="background: rgba(255,255,255,0.4); padding: 15px; border-radius: 8px; border: 1px solid rgba(255,255,255,0.5);">
                                <h4 style="margin-bottom: 10px; color: #1e3a8a;">Passenger ${i}</h4>
                                <div class="form-row">
                                    <div class="form-group">
                                        <label>Full Name</label>
                                        <input type="text" class="pass-name" placeholder="E.g., Rahul Sharma" required>
                                    </div>
                                    <div class="form-group">
                                        <label>Age</label>
                                        <input type="number" class="pass-age" placeholder="E.g., 25" min="1" max="100" required>
                                    </div>
                                </div>
                            </div>
                        `;
                    }
                }

                function updatePrice() {
                    selectedTickets = parseInt(ticketCountSelect.value);
                    const total = currentBaseFare * selectedTickets;
                    summaryTicketsCount.textContent = `x ${selectedTickets}`;
                    summaryTotalFare.textContent = `₹${total}`;
                    renderPassengerRows(selectedTickets);
                }

                // Attach book button events
                document.querySelectorAll('.book-btn').forEach(btn => {
                    btn.addEventListener('click', (e) => {
                        currentScheduleId = e.target.getAttribute('data-id');
                        const desc = e.target.getAttribute('data-desc');
                        currentBaseFare = parseInt(e.target.getAttribute('data-fare'));
                        
                        bookingRouteText.textContent = desc;
                        summaryBaseFare.textContent = `₹${currentBaseFare}`;
                        ticketCountSelect.value = "1";
                        updatePrice();

                        // Transition to Step 1
                        resultsSection.style.display = 'none';
                        bookingFlowSection.classList.remove('hidden');
                        step1Tickets.classList.remove('hidden');
                        step2Payment.classList.add('hidden');
                        step3Success.classList.add('hidden');
                    });
                });

                ticketCountSelect.addEventListener('change', updatePrice);

                document.getElementById('btn-cancel-booking').addEventListener('click', () => {
                    bookingFlowSection.classList.add('hidden');
                    resultsSection.style.display = 'block';
                });

                document.getElementById('btn-proceed-payment').addEventListener('click', () => {
                    if(!bookingForm.checkValidity()) {
                        bookingForm.reportValidity();
                        return;
                    }
                    step1Tickets.classList.add('hidden');
                    step2Payment.classList.remove('hidden');
                });

                document.getElementById('btn-back-tickets').addEventListener('click', () => {
                    step2Payment.classList.add('hidden');
                    step1Tickets.classList.remove('hidden');
                });

                document.getElementById('btn-pay-now').addEventListener('click', () => {
                    const email = document.getElementById('passenger-email').value;
                    const passNames = Array.from(document.querySelectorAll('.pass-name')).map(el => el.value);
                    
                    const btn = document.getElementById('btn-pay-now');
                    btn.textContent = 'Processing...';
                    btn.disabled = true;

                    // Book N tickets
                    const bookingPromises = [];
                    for(let i=0; i<selectedTickets; i++) {
                        const uniqueEmail = `guest_${Date.now()}_${i}@example.com`;
                        bookingPromises.push(
                            fetch(`${API_BASE}/book`, {
                                method: 'POST',
                                headers: { 'Content-Type': 'application/json' },
                                body: JSON.stringify({
                                    schedule_id: currentScheduleId,
                                    passenger_name: passNames[i] || `Passenger ${i+1}`,
                                    passenger_email: uniqueEmail
                                })
                            }).then(res => res.json())
                        );
                    }

                    Promise.all(bookingPromises)
                    .then(results => {
                        const allSuccess = results.every(r => r.success);
                        if(allSuccess) {
                            step2Payment.classList.add('hidden');
                            step3Success.classList.remove('hidden');
                        } else {
                            alert('Booking failed for some tickets.');
                        }
                    })
                    .catch(err => {
                        console.error(err);
                        alert('An error occurred during booking.');
                    })
                    .finally(() => {
                        btn.textContent = 'Pay Now';
                        btn.disabled = false;
                    });
                });

                document.getElementById('btn-book-another').addEventListener('click', () => {
                    bookingFlowSection.classList.add('hidden');
                    resultsSection.style.display = 'block';
                    bookingForm.reset();
                });

            })
            .catch(err => {
                loading.classList.add('hidden');
                console.error(err);
                schedulesContainer.innerHTML = '<p>Error fetching schedules.</p>';
            });
    });
});
