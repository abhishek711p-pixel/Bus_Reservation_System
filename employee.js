const backendUrl = 'http://localhost:3000/api/query';

const queries = {
    view: `SELECT * FROM ActiveSchedulesView`,
    
    join: `
        SELECT 
            p.first_name, 
            p.last_name, 
            b.seat_number, 
            r.source, 
            r.destination
        FROM passengers p
        INNER JOIN bookings b ON p.passenger_id = b.passenger_id
        INNER JOIN schedules s ON b.schedule_id = s.schedule_id
        INNER JOIN routes r ON s.route_id = r.route_id
        WHERE b.status = 'Confirmed'
        ORDER BY p.last_name ASC
    `,
    
    agg: `
        SELECT 
            r.source, 
            r.destination, 
            SUM(p.amount) AS total_revenue,
            COUNT(b.booking_id) AS total_bookings
        FROM routes r
        INNER JOIN schedules s ON r.route_id = s.route_id
        INNER JOIN bookings b ON s.schedule_id = b.schedule_id
        INNER JOIN payments p ON b.booking_id = p.booking_id
        WHERE b.status = 'Confirmed'
        GROUP BY r.route_id, r.source, r.destination
        HAVING total_revenue > 1000
    `,
    
    subquery: `
        SELECT first_name, last_name, email
        FROM passengers
        WHERE passenger_id IN (
            SELECT passenger_id 
            FROM bookings 
            WHERE schedule_id IN (
                SELECT schedule_id 
                FROM schedules 
                WHERE fare = (SELECT MAX(fare) FROM schedules)
            )
        )
    `
};

const loadingMessages = [
    "Fetching that for you...",
    "Gathering the details...",
    "Just a moment please...",
    "Looking that up right now..."
];

async function executeQuery(sqlString) {
    const loading = document.getElementById('loading');
    const loadingText = document.getElementById('loading-text');
    const tableHead = document.getElementById('table-head');
    const tableBody = document.getElementById('table-body');
    
    // Pick a random friendly loading message
    loadingText.innerText = loadingMessages[Math.floor(Math.random() * loadingMessages.length)];
    
    // Show loader, clear table
    loading.classList.remove('hidden');
    tableHead.innerHTML = '';
    tableBody.innerHTML = '';
    
    try {
        const response = await fetch(backendUrl, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ sql: sqlString })
        });
        
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        
        const data = await response.json();
        
        if (data.error) {
            throw new Error(data.error);
        }
        
        // Slight artificial delay to enjoy the soft loader animation
        setTimeout(() => {
            renderTable(data);
            loading.classList.add('hidden');
        }, 800);
        
    } catch (error) {
        console.error("Error executing query:", error);
        loading.classList.add('hidden');
        tableBody.innerHTML = `<tr><td style="color: #e53e3e; text-align: center; padding: 2rem;">Oops! We hit a snag connecting to the database. Is the backend running?</td></tr>`;
    }
}

function renderTable(data) {
    const tableHead = document.getElementById('table-head');
    const tableBody = document.getElementById('table-body');
    
    if (!data || data.length === 0) {
        tableBody.innerHTML = '<tr><td style="text-align: center; color: #718096; padding: 2rem;">It looks like there are no records for this search.</td></tr>';
        return;
    }
    
    // Generate Headers dynamically from the first object keys
    const columns = Object.keys(data[0]);
    let headHtml = '<tr>';
    columns.forEach(col => {
        headHtml += `<th>${col.replace(/_/g, ' ')}</th>`;
    });
    headHtml += '</tr>';
    tableHead.innerHTML = headHtml;
    
    // Generate Rows with Staggered Animation
    let bodyHtml = '';
    data.forEach((row, index) => {
        // Calculate animation delay for stagger effect
        const delay = index * 0.03; // 30ms per row
        bodyHtml += `<tr style="animation-delay: ${delay}s">`;
        columns.forEach(col => {
            let cellData = row[col];
            // Format dates simply
            if (cellData && typeof cellData === 'string' && cellData.includes('T')) {
                cellData = new Date(cellData).toLocaleString(undefined, {
                    year: 'numeric', month: 'short', day: 'numeric',
                    hour: '2-digit', minute: '2-digit'
                });
            }
            bodyHtml += `<td>${cellData}</td>`;
        });
        bodyHtml += '</tr>';
    });
    tableBody.innerHTML = bodyHtml;
}

// Helper function to manage button active states
function setActiveButton(activeId) {
    const buttons = ['btn-view', 'btn-join', 'btn-agg', 'btn-subquery'];
    buttons.forEach(id => {
        const btn = document.getElementById(id);
        if (id === activeId) {
            btn.classList.remove('secondary');
            btn.classList.add('primary');
        } else {
            btn.classList.remove('primary');
            btn.classList.add('secondary');
        }
    });
}

// Attach Event Listeners
document.getElementById('btn-view').addEventListener('click', () => {
    setActiveButton('btn-view');
    executeQuery(queries.view);
});
document.getElementById('btn-join').addEventListener('click', () => {
    setActiveButton('btn-join');
    executeQuery(queries.join);
});
document.getElementById('btn-agg').addEventListener('click', () => {
    setActiveButton('btn-agg');
    executeQuery(queries.agg);
});
document.getElementById('btn-subquery').addEventListener('click', () => {
    setActiveButton('btn-subquery');
    executeQuery(queries.subquery);
});

// Load initial data on page load
window.addEventListener('DOMContentLoaded', () => {
    document.getElementById('btn-view').click();
});

// --- 3D Parallax Effect for Hero Section ---
document.addEventListener('mousemove', (e) => {
    const heroContent = document.querySelector('.hero-content');
    if (heroContent) {
        // Calculate mouse position relative to center of screen
        const xAxis = (window.innerWidth / 2 - e.pageX) / 40;
        const yAxis = (window.innerHeight / 2 - e.pageY) / 40;
        
        // Apply 3D rotation
        heroContent.style.transform = `perspective(1000px) rotateY(${xAxis}deg) rotateX(${yAxis}deg)`;
    }
});
