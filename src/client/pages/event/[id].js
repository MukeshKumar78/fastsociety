import { useRouter } from 'next/dist/client/router';
import { useEffect, useState } from 'react';
import { useFetchUser } from '../../hooks/user';
import Layout from '../../components/Layout';
import Event from '../../components/Events/Event';
import PostsView from '../../components/Posts/PostsView';
import CommentsView from '../../components/Events/CommentsView';
import AddPostBox from '../../components/Posts/AddPostBox';

const EventPage = () => {
    const router = useRouter();
    const [event, setEvent] = useState(null);
    const {token} = useFetchUser();

    useEffect(() => {
        if(!router.isReady) return;
        const { id } = router.query;
        console.log('id', id);
        fetch(`/api/event/${id}`, {
            method: 'GET',
            headers: {'Content-Type': 'application/json', token: token}
        })
        .then(res => res.json())
        .then(event => {
            console.log(event);
            setEvent(event);
        });
    }, [router.isReady]);

    return <Layout>
        {
            event && <>
            <Event data={event} controls={false}/>
            {/* <CommentsView eventId={event.id} /> */}
            <hr/>
            <h2 className='text-center text-muted'>Updates</h2>
            <AddPostBox eventId={event.id} societyId={event.society.id}/>
            <PostsView eventId={event.id}/>
            </>
        }
        </Layout>
}

export default EventPage;